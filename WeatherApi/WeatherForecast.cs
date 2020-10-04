using System;

namespace WeatherApi {
    public class WeatherForecast {
        private const int FConversion = 32;
        public DateTime Date { get; set; }

        public int TemperatureC { get; set; }

        public int TemperatureF => FConversion + (int) (TemperatureC / 0.5556);

        public string Summary { get; set; }
    }
}