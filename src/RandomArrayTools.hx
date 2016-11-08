package;

class RandomArrayTools{

  public static inline function int(from:Int, to:Int):Int
	{
		return from + Math.floor(((to - from + 1) * Math.random()));
  }

  static public function shuffle<T>(array:Array<T>):Array<T>{

    var j:Int;

    if(array == null){
      return array;
    }

    for( i in 0...array.length){
      j = int(0, array.length-1);

      var e1 = array[i];
      var e2 = array[j];
      array[i] = e2;
      array[j] = e1;

    }

    return array;

  }
}
