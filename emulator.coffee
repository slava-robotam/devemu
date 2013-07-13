class Model
  constructor: ->
    @va = 0
    @v = 0

    @angle = 0
    @position = [100,100]

  velocity: (@v) ->
  angular_vel: (@va) ->

  setup: (options) ->
    @[prop] = options[prop] for prop of options

System =
  models: []

  init: ->
    @container = document.querySelector('.container')

  getModel: ->
    model = new Model()
    model.element = @getElement()
    @models.push model
    model

  getElement: ->
    div = document.createElement 'div'
    div.className = 'model'

    cabin = document.createElement 'div'
    cabin.className = 'cabin'
    div.appendChild cabin

    @container.appendChild div

    div

  run: ->
    @time = 0
    @step = 1/60
    model.init() for model in @models
    @runStep()

  runStep: ->
    @time += @step
    for model in @models
      model.loop @time
      model.angle += model.va * @step

      [x,y] = model.position
      x += model.v * Math.sin(model.angle) * @step
      y -= model.v * Math.cos(model.angle) * @step
      model.position = [x,y]

    @render()

    requestAnimationFrame @runStep.bind(@)

  render: ->
    for model in @models
      model.element.style.webkitTransform =
        "rotate(#{model.angle}rad)"

      model.element.style.left = model.position[0] + 'px'
      model.element.style.top = model.position[1] + 'px'


  load: (code) ->
    robot = System.getModel()
    eval code.replace /loop\(/, "loop_("

    robot.init = init
    robot.loop = loop_

    System.run()

  translate: (code) -> code

System.init()
