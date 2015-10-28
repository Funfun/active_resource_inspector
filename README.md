ActiveResource Inspector
========================

The gem provides ability to inspect ActiveResource files of any ruby project.

Using the `Rake` task, it prints results in format much like Rails's rake route does, but here it grouped by host and authentication type.

Case for Rails project:
-----------------------

For example in your Rails project you could have ActiveResource model like so:

```
class Inventory < ActiveResource::Base
  include ActiveResource::Singleton
  self.site = 'http://example.com:3000'
  self.prefix = '/products/:product_id/'
end
```

and you type within project folder:

```
rake resources:list
```

you will get:

```
~/you_rails_project$ rake resources:list
Location: /Users/tsyren/code/book_store/app/models

http://37s.sunrise.i:3000 (no auth)
                                    /products/:product_id/inventories.json
```

Case for non-Rails project:
---------------------------

For non-Rails project you need to pass the path manually, for example you stored your active resource files in `./app/resources` folder then:

```
rake resources:list["./app/resources"]
```

and the result expected the same as above example.

Installation
------------

```
gem 'active_resource_inspector', group: :development
```

or

```
gem install active_resource_inspector
```

note: aims for development usage only.

Give try and drop me feedback.
