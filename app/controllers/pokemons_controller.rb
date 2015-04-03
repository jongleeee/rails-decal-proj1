class PokemonsController < ApplicationController

  def capture
    id = params[:id].to_i
    @pokemon = Pokemon.where(id:id).first
    @pokemon.trainer_id = current_trainer.id.to_i
    @pokemon.save
    redirect_to '/'
  end

  def damage
    id = params[:id].to_i
    @pokemon = Pokemon.where(id:id).first
    @pokemon.health -= 10
    if (@pokemon.health == 0)
    	@pokemon.delete
    else
      @pokemon.save
    end
    redirect_to :back
  end

  def new
  	@pokemon = Pokemon.new
  end

  def create
	@pokemon = Pokemon.create(pokemon_params)
	@pokemon.trainer_id = current_trainer.id.to_i
	@pokemon.health = 100
	@pokemon.level = 1
	if @pokemon.save
		redirect_to trainer_path(current_trainer.id.to_i)
	else
    flash[:error] = @pokemon.errors.full_messages.to_sentence
		render "new"
	end
  end


  	def pokemon_params
	  params.require(:pokemon).permit(:name) #Returns a hash that was the value of "name" and "email" from the value of "user" in params.
	end

end