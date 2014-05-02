// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require backbone
//= require_tree .
//= require bootstrap

$(function(){

  var Bet = Backbone.Model.extend({
    url: function() {
      var base = 'bets';
      if (this.isNew()) return base + '?week=' + location.search.replace(/\?week=(\d)/, "$1");
      return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.id;
    },

    defaults: function() {
      return {};
    }

  });

  var BetList = Backbone.Collection.extend({
    model: Bet,

    url: function() {
      var base = 'bets';
      if (!this.get("id")) return base + '?week=' + location.search.replace(/\?week=(\d)/, "$1");
      return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.get("id");
    }
  });

  var betList = new BetList();

  var BetView = Backbone.View.extend({
    tagName:  "div",

    events: {
      "dblclick .bettable" : "edit",
      "keypress .bettable" : "updateOnEnter"
      //"blur     .teams" : "close"
    },

    template: _.template($('#bet-template').html()),

    initialize: function() {
      this.$el.addClass('list-group-item row bet');
      this.listenTo(this.model, 'change',  this.render);
      this.listenTo(this.model, 'destroy', this.remove);
    },

    render: function() {
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    },

    edit: function() {
      this.$el.addClass("editing");
      this.$el.find("input:first").focus();
      this.$el.find("input:first").select();
      this.$el.find("input").prop("disabled", false);
    },

    close: function() {
      var team_home_goals = this.$el.find("input:first").val();
      var team_away_goals = this.$el.find("input:last").val();
      if (!team_home_goals || !team_away_goals) {
        this.clear();
      } else {
        this.model.save({ team_home_goals: team_home_goals, team_away_goals: team_away_goals });
        this.$el.removeClass("editing");
        this.$el.find("input").prop("disabled", true);
      }
    },

    updateOnEnter: function(e) {
      if (e.keyCode == 13) this.close();
    }
  });

  var AppView = Backbone.View.extend({
    el: $("#bets"),

    initialize: function() {
      this.listenTo(betList, 'add',   this.addOne);
      this.listenTo(betList, 'reset', this.addAll);
      this.listenTo(betList, 'all',   this.render);

      betList.fetch();
    },

    addOne: function(bet) {
      var view = new BetView({model: bet});
      this.$el.append(view.render().el);
    },

    addAll: function() {
      betList.each(this.addOne, this);
    }
  });

  var App = new AppView;
});
