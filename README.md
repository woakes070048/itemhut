######Minor Note

omark program is a work in progress. I often reset the repo and there are many work-in-progress notes included in the files that will not appear in the final program. Thank you for coming by and taking a look.


#omark

omark is a free and open-source marketing, ERP, CRM, and channel-management tool mainly focusing on B2B.

######Why?

In various professional roles, I have discovered that the marketing, ERP, CRM, and channel-management tools (all closed source) have never met the needs and expectations of the companies I have worked for. In response to these short-comings, I have always developed in-house databases and programs to further manage the complexity of the jobs I had to do.

This program can serve as a cheat-sheet for those who find themselves in my position and don't know where to start, or it can serve as a foundation for those who want to build their own solutions. This program is fundamentally different because it is created by someone who has found himself in the mud.

omark makes a few assumptions that do not reflect reality: in particular, it assumes you have beautiful and clean data, ignoring the mantra "Data is Messy." Yes, data is, and always will be, messy, even with the best of plans. I am not able to know *how* your data is messy. With that in mind, omark attempts to be as flexible as possible, and should be easy to modify. The databaase schema does provide lookup tables that represent some of the more common cases.

######Expected Features
* B2B Customer Management
* Inventory Management
* Basic Warehouse Management
* Intensive marketing analysis
* "Feature Complete" Ebay and Amazon API integration.
* Flat File creation
* Excellent Documentation (mostly found in the source code)

There are items I have not listed yet.

######Implementation considerations:
To start, I am using JSON to interact with PostgresSQL, where it is then processed into a sane schema. I do plan to add Python dict() and XML interop.

Since I am not able to test half.com at this time, I have no plans to implement the these features. 

The code assumes you'd like to use a .yaml file to keep your credentials. I do not include the .yaml file. You can find the yaml file [here](https://github.com/timotheus/ebaysdk-python/blob/master/ebay.yaml). Place it in /omark/pyebay/ebay.yaml.

######Current Status
Python is currently talking to PostgreSQL. The only feature that works at this time is insertion into PostgreSQL and a bit of processing.

Instead of requiring virtualenv or other tools to keep Python 2 and 3 separate, I simply call Python2 in the file headers.

######Components

* PostgreSQL 9.3
* PL/pgSQL
* C
* Python 2.7

######Where is the GUI?
There are no plans to create a GUI component.

######Permissions and Licensing

While I am unable to enforce this, I am a strong believer that a customer's data is their data. I ask that, if you use this program, you allow your customers to own all the data they have supplied to you either through their own input or through the APIs.

While I do not require this, I am interested in spreading the word about this program. If you wish to use this program, please offer attribution.

Released under the [Mozilla Public License
Version 2.0](http://www.mozilla.org/MPL/2.0/)