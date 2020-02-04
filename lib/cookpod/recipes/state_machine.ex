defmodule Cookpod.Recipes.StateMachine do
  use Fsm, initial_state: "draft"

  defevent publish do
    next_state("published")
  end

  defevent hide do
    next_state("draft")
  end

  def restore(recipe) do
    Cookpod.Recipes.StateMachine.new(state: recipe.state, data: recipe)
  end
end
