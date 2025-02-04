<!-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/. -->

% rebase('global/base.tpl')

<div class="expanded row">
  <div class="medium-2 columns">

    % include('vendors/vendor_side_nav.tpl', vendor_info = vendor_info)
  </div>

  <div class="medium-10 columns">
    <form action="/vendors/{{vendor_info[0][0]}}/edit-vendor" method="POST">

      <div class="row">
	<div class="medium-3 columns">
	  <label>Vendor ID
	    <input type="text" name="vendor-id" required="required"
		   value = "{{vendor_info[0][0]}}">
	  </label>
	</div>
	<div class="medium-3 columns">
	  <label>Vendor Name
	    <input type="text" name="vendor-name"
		   required="required" value = "{{vendor_info[0][1]}}">
	  </label>
	</div>
	<div class="medium-6 columns">
	</div>
      </div>

      <div class="row">
	<div class="medium-3 columns">
	  <label>Phone
	    <input type="text" name="phone"
		   value = "{{vendor_info[0][2]}}">
	  </label>
	</div>
	<div class="medium-3 columns">
	  <label>fax
	    <input type="text" name="fax"
		   value = "{{vendor_info[0][3]}}">
	  </label>
	</div>
	<div class="medium-6 columns">
	</div>
      </div>

      <div class="row">
	<div class="medium-3 columns">
	  <label>Website
	    <input type="text" name="website"
		   value = "{{vendor_info[0][4]}}">
	  </label>
	</div>
	<div class="medium-3 columns">
	  <label>Email
	    <input type="email" name="email"
		   value = "{{vendor_info[0][5]}}">
	  </label>
	</div>
	<div class="medium-6 columns">
	</div>
      </div>

      <div class="row">
	<div class="medium-3 columns">
	  <label>Street
	    <input type="text" name="street"
		   value = "{{vendor_info[0][6]}}">
	  </label>
	</div>
	<div class="medium-3 columns">
	  <label>City
	    <input type="text" name="city"
		   value = "{{vendor_info[0][7]}}">
	  </label>
	</div>
	<div class="medium-3 columns">
	  <label>State
	    <input type="text" name="state"
		   value = "{{vendor_info[0][8]}}">
	  </label>
	</div>
	<div class="medium-3 columns">
	</div>
      </div>


      <div class="row">
	<div class="medium-3 columns">
	  <label>Zip Code
	    <input type="text" name="zip"
		   value = "{{vendor_info[0][9]}}">
	  </label>
	</div>
	<div class="medium-3 columns">
	  <label>Country
	    <input type="text" name="country"
		   value = "{{vendor_info[0][10]}}">
	  </label>
	</div>
	<div class="medium-3 columns">
	</div>
      </div>
      <input type="submit" class="button" value="Update Vendor" name="update-vendor">

    </form>


  </div>

  <!-- close wrapper, no more content after this -->

</div>

<script>
  $(document).ready( function () {
  $('#table_id').DataTable();
  } );
</script>
