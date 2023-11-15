extension StringExtension on String {
  String toCapitalize() {
    if(this!=null){
      if(this.length>0){
        return "${this[0].toUpperCase()}${this.substring(1)}";
      }
      else{
        return "";
      }

    }
    else{
      return "";

    }

  }
}