String removeDashes(String target) {
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < target.length; i++) {
      if (target[i] != '-') {
        sb.write(target[i]);
      }
    }
    return sb.toString();
  }