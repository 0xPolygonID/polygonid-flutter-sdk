abstract class Mapper<From, To> {
  To mapFrom(From from);

  From mapTo(To to);
}
