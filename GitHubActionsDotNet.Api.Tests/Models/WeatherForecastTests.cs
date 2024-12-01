using FluentAssertions;
using GitHubActionsDotNet.Api.Models;

namespace GitHubActionsDotNet.Api.Tests.Models
{
    public class WeatherForecastTests
    {
        [Fact]
        public void TemperatureFShouldReturnCorrectValueBasedOnTemperatureC()
        {
            var weatherForecast = new WeatherForecast
            {
                TemperatureC = 0
            };

            weatherForecast.TemperatureF.Should().Be(32);
        }
    }
}
