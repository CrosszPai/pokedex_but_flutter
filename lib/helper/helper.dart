List<int> generationToLimit(int generation) {
  int start = 0;
  int end = 0;
  switch (generation) {
    case 1:
      start = 1;
      end = 151;
      break;
    case 2:
      start = 152;
      end = 251;
      break;
    case 3:
      start = 252;
      end = 386;
      break;
    case 4:
      start = 387;
      end = 493;
      break;
    case 5:
      start = 494;
      end = 649;
      break;
  }
  return [start, end];
}
