puts "BEGIN: Adding Staff and Admin Users"
User.create!([
  {first_name:"Randy",last_name:"Burgess",email:"wrburgess@gmail.com",roles:[Roles::ADMIN],password:"EyJDUFqE96UbjesiNKiKm73Lw9mzEa4ja6WF3Xjg9Z7GMPVGvq",password_confirmation:"EyJDUFqE96UbjesiNKiKm73Lw9mzEa4ja6WF3Xjg9Z7GMPVGvq" },
])
puts "END:   Adding Staff and Admin Users"
