from django.db.expressions import Func

class Aggregate(Func): ...
class Avg(Aggregate): ...
class Count(Aggregate): ...
class Max(Aggregate): ...
class Min(Aggregate): ...
class StdDev(Aggregate): ...
class Sum(Aggregate): ...
class Variance(Aggregate): ...
