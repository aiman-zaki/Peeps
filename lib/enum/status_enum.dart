enum Status{
  done,
  ongoing,
}

String getStatusEnumString(Status status){
  Map<Status,String> enumString = {
    Status.done:"Done",
    Status.ongoing:"Ongoing"
  };

  return enumString[status];
}
