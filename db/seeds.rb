User.destroy_all

User.create!([{
    email: "kamyar2083@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    role: :admin
},])