<!-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/. -->

% rebase('global/base.tpl')

<div class="expanded row">
  <div class="medium-2 columns">
    <h4 color = >{{wh_info[0][1]}}</h4>
    % include('warehouse/side_nav_menu.tpl', wh_id = wh_info[0][0])
  </div>
  <div class="medium-10 columns">
    <h4>Update Picking Location</h4>

    <form action="/warehouses/{{wh_info[0][0]}}/update-picking-location-{{pid}}" method="POST">
      <div class="row">
	<div class="medium-3 columns">
	  <label>Picking Location
	    <input type="text" name="picking-location"
		   value="{{pl_info[0][0]}}"required="required">
	  </label>

	  <div class="medium-9 columns">
	  </div>
	</div>
      </div>
      <div class="row">
	<div class="medium-3 columns">
	  <label>UPC
	    <input list="upc_list" name="upc"
		   value="{{pl_info[0][1]}}" style="margin-top:2em;">
	  </label>
	  <datalist id="upc_list">
	    % for item in sku_upc:
	    <option value="{{item[1]}}">
	      % end
	  </datalist>
	</div>
	<div class="medium-3 columns">
	  <label>Qty
	    <input type="number" min="0" value="{{pl_info[0][2]}}"
		   name="qty">
	  </label>
	</div>
	<div class="medium-6 columns">
	</div>

      </div>

      <input type="submit" class="button"
	     value="Update Picking Location" name="update-picking-location">
    </form>
  </div>

</div>
