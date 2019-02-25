(function() {
  
  function updateChooser(chooser) {
    chooser = $(chooser);
    var left = chooser.find("select.left");
    var right = chooser.find("select.right1");

    var right1 = chooser.find("select.right1");
    var right2 = chooser.find("select.right2");

    var leftArrow = chooser.find(".left-arrow");
    var rightArrow = chooser.find(".right-arrow");
    var leftArrow1 = chooser.find(".left-arrow1");
    var rightArrow1 = chooser.find(".right-arrow1");
    var leftArrow2 = chooser.find(".left-arrow2");
    var rightArrow2 = chooser.find(".right-arrow2");
    
    var canMoveTo = (left.val() || []).length > 0;
    var canMoveFrom = (right.val() || []).length > 0;
    
    var canMoveFrom1 = (right1.val() || []).length > 0;
    var canMoveFrom2 = (right2.val() || []).length > 0;
    
    leftArrow.toggleClass("muted", !canMoveFrom);
    rightArrow.toggleClass("muted", !canMoveTo);
    
    leftArrow1.toggleClass("muted", !canMoveFrom);
    rightArrow1.toggleClass("muted", !canMoveTo);
    leftArrow2.toggleClass("muted", !canMoveFrom);
    rightArrow2.toggleClass("muted", !canMoveTo);
  }
  
  function move(chooser, source, dest) {
    chooser = $(chooser);
    var selected = chooser.find(source).children("option:selected");
    var dest = chooser.find(dest);
    dest.children("option:selected").each(function(i, e) {e.selected = false;});
    dest.append(selected);
    updateChooser(chooser);
    chooser.trigger("change");
  }
  
  $(document).on("change", ".chooser select", function() {
    updateChooser($(this).parents(".chooser"));
  });
  
  $(document).on("click", ".chooser .right-arrow1", function() {
    move($(this).parents(".chooser"), ".left", ".right1");
  });
  
  $(document).on("click", ".chooser .right-arrow2", function() {
    move($(this).parents(".chooser"), ".left", ".right2");
  });
  
  $(document).on("click", ".chooser .left-arrow1", function() {
    move($(this).parents(".chooser"), ".right1", ".left");
  });
  
  $(document).on("click", ".chooser .left-arrow2", function() {
    move($(this).parents(".chooser"), ".right2", ".left");
  });
  
  $(document).on("dblclick", ".chooser select.right1", function() {
    move($(this).parents(".chooser"), ".right1", ".left");
  });
  
  $(document).on("dblclick", ".chooser select.right2", function() {
    move($(this).parents(".chooser"), ".right2", ".left");
  });

  
  var binding = new Shiny.InputBinding();
  
  binding.find = function(scope) {
    return $(scope).find(".chooser");
  };
  
  binding.initialize = function(el) {
    updateChooser(el);
  };
  
  binding.getValue = function(el) {
    return {
      left: $.makeArray($(el).find("select.left option").map(function(i, e) { return e.value; })),
      right1: $.makeArray($(el).find("select.right1 option").map(function(i, e) { return e.value; })),
      right2: $.makeArray($(el).find("select.right2 option").map(function(i, e) { return e.value; })),
    };
  };
  
  binding.setValue = function(el, value) {
    // TODO: implement
  };
  
  binding.subscribe = function(el, callback) {
    $(el).on("change.chooserBinding", function(e) {
      callback();
    });
  };
  
  binding.unsubscribe = function(el) {
    $(el).off(".chooserBinding");
  };
  
  binding.getType = function() {
    return "shinyjsexamples.chooser";
  };
  
  Shiny.inputBindings.register(binding, "shinyjsexamples.chooser");
  
})();