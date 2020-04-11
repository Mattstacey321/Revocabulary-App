String wordType(String type){
  switch (type) {
    case "a":
      return "Adjective";
      break;
    case "v":
      return "Verb";
    break;
    case "n":
      return "Noun";

    default: return "Unknown";
  }
}