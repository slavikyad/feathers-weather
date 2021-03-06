package feathers.examples.weather.controller
{
	import feathers.data.ListCollection;
	import feathers.examples.weather.model.FavoriteLocationsModel;
	import feathers.examples.weather.model.ForecastModel;
	import feathers.examples.weather.model.LocationItem;

	import org.robotlegs.starling.mvcs.Command;

	public class FavoriteLocationsLoadCompleteCommand extends Command
	{
		private static const DEFAULT_LOCATION_ITEMS:Vector.<LocationItem> = new <LocationItem>[
			new LocationItem("San Francisco", "2487956", "California, United States"),
			new LocationItem("New York", "2459115", "New York, United States"),
		];

		[Inject]
		public var forecastModel:ForecastModel;

		[Inject]
		public var favoriteLocationsModel:FavoriteLocationsModel;

		override public function execute():void
		{
			var favoriteLocations:ListCollection = this.favoriteLocationsModel.favoriteLocations;
			if(favoriteLocations.length > 0)
			{
				var firstLocation:LocationItem = LocationItem(favoriteLocations.getItemAt(0));
				this.forecastModel.selectLocation(firstLocation);
			}
			else
			{
				//this will happen if the file was corrupt or doesn't exist yet
				var count:int = DEFAULT_LOCATION_ITEMS.length;
				for(var i:int = 0; i < count; i++)
				{
					var item:LocationItem = DEFAULT_LOCATION_ITEMS[i];
					this.favoriteLocationsModel.addFavoriteLocation(item);
					if(i == 0)
					{
						this.forecastModel.selectLocation(item);
					}
				}
			}
		}
	}
}
