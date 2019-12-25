enum ActionComplaint{
  deduction,
  consult,
}


String getActionComplaintEnumString(ActionComplaint actionComplaint){
  Map<ActionComplaint,String> enumString = {
    ActionComplaint.consult:"Consult",
    ActionComplaint.deduction:"Deduction"
  };

  return enumString[actionComplaint];

}