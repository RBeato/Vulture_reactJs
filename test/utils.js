//25 Add this function
exports.assertVMException = error => {
  const hasException = error.toString().search("VM Exception");
  assert(hasException, "Should expect a VM Exception error");
}