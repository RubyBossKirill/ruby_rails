require 'sqlite3'

module Authentication
    class UserAuth
        @@USER_DATABASE = 'database/user_accounts.sqlite'
        @@NAME_USER_DATABASE = 'user_accounts'
        attr_accessor :login

        def self.valid_email?(email)
            email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
            !!(email =~ email_regex)
        end

        def self.valid_password?(password)
            password_regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$/
            !!(password =~ password_regex)
        end

        def initialize(email, password, login = nil, member = "user")
            @email = email
            @login = login
            @password = password
            @creat_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
            @member = member
        end
        def registered
            hash = {
                "email" => @email.to_s,
                "login" => @login.to_s,
                "password" => @password.to_s,
                "creat_at" => @creat_at,
                "member" => @member.to_s
            }
            save_to_db(hash)
        end

        def user_auth
            result = search_auth_user(@email, @password)
        end

        private

        def save_to_db(hash)
            db = SQLite3::Database.open(@@USER_DATABASE)
            db.results_as_hash = true

            db.execute <<-SQL
                CREATE TABLE IF NOT EXISTS #{@@NAME_USER_DATABASE} (
                    id INTEGER PRIMARY KEY,
                    email TEXT,
                    login TEXT,
                    password TEXT,
                    creat_at DATETIME,
                    member TEXT
                );
            SQL

            db.execute(
                "INSERT INTO #{@@NAME_USER_DATABASE} (" +
                    hash.keys.join(',') + ")" +
                    "VALUES (" +
                    ('?,'*hash.keys.size).chomp(',') +
                    ")",
                    hash.values
            )

            db.close
        end

        def search_auth_user(email, password)
            db = SQLite3::Database.open(@@USER_DATABASE)
            db.results_as_hash = true

            db_result = db.execute("SELECT * FROM #{@@NAME_USER_DATABASE} WHERE email = ?", email)

            db.close
            if !db_result.empty?
                db_email = db_result[0]['email']
                db_password = db_result[0]['password']
                @login = db_result[0]['login']

                return db_email == email && db_password == password
            else
                return
            end
        end
    end
end