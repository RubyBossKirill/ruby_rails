module Authentication
    class UserAuth
        @@USER_DATABASE = '../database/user_accounts.sqlite'

        def self.valid_email?(email)
            email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
            !!(email =~ email_regex)
        end

        def self.valid_password?(password)
            # Регулярное выражение для проверки пароля
            # Пароль должен содержать как минимум 8 символов, включая хотя бы одну заглавную букву, одну строчную букву и одну цифру.
            password_regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$/
            # Проверка совпадения пароля с регулярным выражением
            password =~ password_regex
        end

        def initialize(email, login, password, member = "user")
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
            db = SQLite3::Database.open(@@USER_DATABASE)
            db.results_as_hash = true

            db.execute <<-SQL
                CREATE TABLE IF NOT EXISTS user_accounts (
                    id INTEGER PRIMARY KEY,
                    email TEXT,
                    login TEXT,
                    password TEXT,
                    creat_at DATETIME,
                    member TEXT
                );
            SQL

            db.execute(
                "INSERT INTO user_accounts (" +
                    hash.keys.join(',') + ")" +
                    "VALUES (" +
                    ('?,'*hash.keys.size).chomp(',') +
                    ")",
                    hash.values
            )

            db.close
        end
    end
end