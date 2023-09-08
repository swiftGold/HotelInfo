protocol CoordinatorOutput: Coordinator {
  var onFinish: (() -> Void)? { get set }
}
