// Function to Sum two strings net data to one double GB value
double sumAndConvertToMb(String value1, String value2) {
  double value =
      (convertToMb(value1)+convertToMb(value2));
  return value;
}

// Function to convert one String net data to one double GB value
double convertToGb(String value) {
  double valor = 0;

  if (value.contains("KB")) {
    valor = double.parse((value).replaceAll("KB", "")) / (1000 * 1000);
  } else if (value.contains("MB")) {
    valor = double.parse((value).replaceAll("MB", "")) / 1000;
  } else if (value.contains("GB")) {
    valor = double.parse((value).replaceAll("GB", ""));
  } else if (value.contains("B")) {
    valor = double.parse((value).replaceAll("B", "")) / (1000 * 1000 * 1000);
  }
  return valor;
}

// Function to convert one String net data to one double MB value
double convertToMb(String value) {
  double valor = 0;
  
  if (value.contains("KB")) {
    valor = double.parse((value).replaceAll("KB", "")) / (1000);
  } else if (value.contains("GB")) {
    valor = double.parse((value).replaceAll("GB", "")) * 1000;
  } else if (value.contains("MB")) {
    valor = double.parse((value).replaceAll("MB", ""));
  } else if (value.contains("B")) {
    valor = double.parse((value).replaceAll("B", "")) / (1000 * 1000);
  }
  return valor;
}
