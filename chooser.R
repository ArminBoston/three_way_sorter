chooserInput <- function(inputId, label, leftLabel, rightupLabel, rightdownLabel, leftChoices, rightBox1Choices, rightBox2Choices,
                         size1 = 10, size2=5, multiple = FALSEE) {
  
  leftChoices <- lapply(leftChoices, tags$option)
  rightBox1Choices <- lapply(rightBox1Choices, tags$option)
  rightBox2Choices <- lapply(rightBox2Choices, tags$option)
  
  if (multiple)
    multiple <- "multiple"
  else
    multiple <- NULL
  
  tagList(
    singleton(tags$head(
      tags$script(src="chooser-binding.js"),
      tags$link(rel="stylesheet", type="text/css", href="chooser.css")
    )),
    div(tags$b(label)),
    div(id=inputId, class="chooser",
        div(id="leftbox", class="chooser-container chooser-left-container",
            tags$h4(leftLabel),
            tags$select(id="leftSelected", class="left", size=size1, multiple=multiple, leftChoices)
        ),
        div(id="arrows", class="chooser-container chooser-center-container",
            div(id="arrows1", class="arrowsBox",
                icon("arrow-circle-o-right", "right-arrow1 fa-3x"),
                tags$br(),
                icon("arrow-circle-o-left", "left-arrow1 fa-3x")
            ),
            tags$br(),
            div(id="arrows2", class="arrowsBox",
                icon("arrow-circle-o-right", "right-arrow2 fa-3x"),
                tags$br(),
                icon("arrow-circle-o-left", "left-arrow2 fa-3x")
            )
        ),
        
        div(id="rightbox", class="chooser-container chooser-right-container",
            div(id="rightBox1",
                tags$h4(rightupLabel),
                tags$select(id="right1Selected", class="right1", size=size2, multiple=multiple, rightBox1Choices)
            ),
            tags$br(),
            div(id="rightBox2",
                tags$h4(rightdownLabel),
                tags$select(id="right2Selected", class="right2", size=size2, multiple=multiple, rightBox2Choices)
            )
        )
    )
  )
}

registerInputHandler("shinyjsexamples.chooser", function(data, ...) {
  if (is.null(data))
    NULL
  else
    list(left=as.character(data$left), topright=as.character(data$right1), downright=as.character(data$right2))
}, force = TRUE)
