/**
* TestHelper
* Description:
* ...
* 
* @author hays
* Copyright © 2013 All rights reserved.
**/
package ;

class TestHelper
{
    public static function randomFloat(low:Float = 0.0, high:Float = 1.0):Float
    {
        return Math.floor(Math.random() * (1 + high-low )) + low;
    }

    public static function randomInt( ?low:Int = 0, ?high:Int = 1):Int
    {
        return Std.int( Math.floor(Math.random() * (1 + high-low )) + low );
    }

    public static function randomString( ?strlen:Int = 10 ):String
    {
        var chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        var num_chars:Int = chars.length - 1;
        var randomChar:String = "";
        for ( i in 0...strlen )
        {
            randomChar += chars.charAt(Math.floor(Math.random() * num_chars));
        }
        return randomChar;
    }
}