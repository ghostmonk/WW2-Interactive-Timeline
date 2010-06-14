package ghostmonk.interactive.timeline.utils
{
	public class DateFormatter
	{
		public static const FULL_MONTHS:Array = [ 
					"January",
					"February",
					"March",
					"April",
					"May",
					"June",
					"July",
					"August",
					"September",
					"October",
					"November",
					"December"];
		
		public static const FULL_MONTHS_FR:Array = [ 
					"janvier",
					"février",
					"mars",
					"avril",
					"mai",
					"juin",
					"juillet",
					"août",
					"septembre",
					"octobre",
					"novembre",
					"décembre"];
					
		public static const FULL_DAYS:Array = [
					"Sunday",
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday"];
                    
        public static const FULL_DAYS_FR:Array = [
					"lundi",
					"mardi",
					"mercredi",
					"jeudi",
					"vendredi",
					"samedi",
					"dimanche"];
                    
		public static function getFullDate( date:Date, isEng:Boolean = true ) : String
		{
			return isEng 
				? FULL_DAYS[ date.getUTCDay() ] + " " + FULL_MONTHS[ date.getUTCMonth() ] + " " + date.getUTCDate() + ", " + date.getFullYear()
				: FULL_DAYS_FR[ date.getUTCDay() ] + ", " + date.getUTCDate() + " " + FULL_MONTHS_FR[ date.getUTCMonth() ] + " " + date.getFullYear();
		}

	}
}