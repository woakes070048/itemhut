<!-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/. -->

% rebase('global/base.tpl')

<div class="expanded row">
  <div class="medium-2 columns">
    <h4>Add Product</h4>
    % include('products/product_side_nav')
  </div>

  <div class="medium-10 columns">
    % if new_sku:
    <p>Added {{new_sku}}</p>
    % end
    <form action="/products/add-product" method="POST"
	  enctype="multipart/form-data">

      <div class="row">
	<div class="medium-2 columns">
	  <label>Sku
	    <input type="text" name="sku" required="required">
	  </label>
	</div>

	<div class="medium-2 columns">
	  <label>UPC
	    <input type="text" name="upc">
	  </label>
	</div>

	<div class="medium-2 columns">
	  <label>SKU Type
	    <select name="sku-type">
	      % for item in sku_types:
	      <option value="{{item['sku_type']}}">
		{{item["sku_type"]}}</option>
	      % end
	    </select>
	  </label>
	</div>

	<div class="medium-2 columns">
	  <label>Product Name
	    <input type="text" name="product-name" required="required">
	  </label>
	</div>

	<div class="medium-4 columns">
	</div>

      </div>
      <div class="row">
	<div class="medium-6 columns">
	  <label>Product Description
	    <textarea name="product-description"></textarea>
          </label>
	  <div class="medium-6 columns">
	  </div>
	</div>
      </div>

      % for item in ["One", "Two", "Three", "Four", "Five"]:
      <div class="row">
	<div class="medium-6 columns">
	  <label>Bullet {{item}}
	    <input type="text" name="bullet-{{item.lower()}}">
	  </label>
	  <div class="medium-6 columns">
	  </div>
	</div>
      </div>
      % end

      <div class="row">
	<div class="medium-6 columns">
	  <label>Main Image
	    <input type="file" name="main-image">
	  </label>
	  <div class="medium-6 columns">
 	  </div>
	</div>
      </div>

      % for item in ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve"]:
      <div class="row">
	<div class="medium-6 columns">
	  
	  <label>Image {{item.title()}}
	    <input type="file" name="image-{{item}}">
	  </label>
	  <div class="medium-6 columns">
	  </div>
	</div>
      </div>
      % end

      <div class="row">
	<div class="medium-6 columns">

	  <label>Swatch Image
	    <input type="file" name="swatch-image">
	  </label>
	  <div class="medium-6 columns">
	  </div>
	</div>
      </div>

      <div class="row">
	<div class="medium-2 columns">
	  <input type="submit" class="button" value="Add Product" name="add-product">
	</div>
      </div>

    </form>
  </div>
</div>
