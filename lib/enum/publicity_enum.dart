enum Publicity{
  private,
  public,
}


String getPublicityEnumString(Publicity data){
  Map<Publicity,dynamic> map = {
      Publicity.private:"Private",
      Publicity.public:"Public"
    };

    return map[data];
}
