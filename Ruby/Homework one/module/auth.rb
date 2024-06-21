require 'sqlite3'

module Authentication
    class UserAuth
        NAME_USER_DATABASE = 'user_accounts'
        attr_reader :login
        attr_accessor :member
        # self метод для email
        def self.valid_email?(email)
            email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
            !!(email =~ email_regex)
        end
        # self метод для password
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
            @db = Database.new(NAME_USER_DATABASE)
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
            search_auth_user(@email, @password)
        end

        private

        def save_to_db(hash)
            @db.insert_into(hash)
        end

        def search_auth_user(email, password)
            db_result = @db.search_position(email, 'email')
            if !db_result.empty?
                db_email = db_result[0]['email']
                db_password = db_result[0]['password']
                @login = db_result[0]['login']
                @member = db_result[0]['member']

                return db_email == email && db_password == password
            else
                return
            end
        end
    end
end