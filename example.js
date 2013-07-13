var robot = System.getModel()

var robot.setup({
  init: function() {
    this.v = 1;
    this.va = 0; // rad
  },

  loop: function(time) {
    this.va = time * 0.1;
  }
})

System.run()
