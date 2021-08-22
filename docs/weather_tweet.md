# Tweet Weather

This example will create a Job wich will fetch from the [OpenWeatherMap](http://openweathermap.org/) the weather and forecast of next five days, it will calculate the average temperature for next five days and create a tweet with the result.

## Request
POST `/weather_tweet`
```json
{
  "city": "Cascavel",
  "state": "PR",
  "country": "BR"
}
```

## Response
Should be a `No content` response

## Tweet example
```
Em Cascavel: céu limpo, 19.27°C. Média para os próximos dias: 23.18°C em 22/08, 23.23°C em 23/08, 25.59°C em 24/08, 26.16°C em 25/08, 14.05°C em 26/08 e 10.39°C em 27/08
```
