## META PROGRAMMING IN RUBY

#### The Object Model

  - module path names work just like a file structure

  ```ruby
  module M
    class C
      X = "constant"
    end
  end

  M::C::X

  module M
    Y = "constant"
    class C
      ::M::Y
      # to move up the tree
    end
  end

  module M
    class C
      Module M2
        Module.nesting # [M::C::M2, M::C, M]
      end
    end
  end
  ```

  * DEF: receiver, the object that a method gets called on.
  * DEF: ancestors chain, the heierarchy of classes from a class to Object.


  - note; private methods are called with the implicit receiver self



