enum Role{
  admin,
  supervisor,
  student,
}


String getRoleStringEnum(Role role){
  Map<Role,dynamic> roles = {
    Role.admin:"Admin",
    Role.supervisor:"Supervisor",
    Role.student:"Student,"
  };
}