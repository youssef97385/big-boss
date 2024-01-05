String getFormattedOrderStatus(int status) {
  if (status == 1) {
    return "Canceled";
  }
  if (status == 2) {
    return "ordered";
  }
  if (status == 3) {
    return "preparing";
  }
  if (status == 4) {
    return "On the way";
  }
  if (status == 5) {
    return "Received";
  }

  return "Received";
}
