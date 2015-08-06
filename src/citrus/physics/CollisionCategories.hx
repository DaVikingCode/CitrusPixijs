package citrus.physics;

import Reflect;
class CollisionCategories {

    static private var _allCategories = 0;
    static private var _numCategories = 0;
    static private var _categoryIndexes = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384];
    static private var _categoryNames = {};

    static public function has(categories:UInt, theCategory:UInt):Bool {

        return cast(categories & theCategory);
    }

    static public function add(categoryName:String) {

        if (Reflect.hasField(_categoryNames, categoryName))
            return;

        if (_numCategories == 15)
            throw "You can only have 15 categories.";

        Reflect.setProperty(_categoryNames, categoryName, _categoryIndexes[_numCategories]);
        _allCategories |= _categoryIndexes[_numCategories];
        _numCategories++;
    }

    static public function get(args:Array<String>):UInt {

        var categories = 0;

        for (name in args) {

            var category = Std.int(Reflect.getProperty(_categoryNames, name));

            if (category == 0) {

                trace("Warning: " + name + " category does not exist.");
                continue;
            }

            categories |= category;
        }

        return categories;
    }

    /**
    * Returns an integer representing all categories.
    */
    static public function getAll():UInt {

        return _allCategories;
    }

    static public function getAllExcept(args:Array<String>):UInt {

        var categories = 0;

        for (name in args) {

            var category = Std.int(Reflect.getProperty(_categoryNames, name));

            if (category == 0) {

                trace("Warning: " + name + " category does not exist.");
                continue;
            }

            categories &= ~category;
        }

        return categories;
    }

    /**
    * Returns the number zero, which means no categories. You can also just use the number zero instead of this function (but this reads better).
    */
    static public function getNone():UInt {

        return 0;
    }
}
