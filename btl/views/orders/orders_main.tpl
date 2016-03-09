<!-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/. -->

% rebase('global/base.tpl')

<div class="off-canvas-content" data-off-canvas-content>

  <div class="expanded row">
    <div class="medium-2 columns">
      <h4>Orders</h4>
      % include('orders/orders_side_nav.tpl')
    </div>
    
    <div class="medium-10 columns">
      <h4>All Orders</h4>
      <table id="table_id" class="display">
	<thead>
	  <tr>
	    <th>Order ID</th>
	    <th>Market Order ID</th>
	    <th>Market Name</th>
	    <th>Product SKU</th>
	    <th>Marketplace SKU</th>
	    <th>QTY</th>
	    <th>Order Date</th>
	  </tr>
	</thead>
	<tbody>
	  % for i in orders:
	  <tr>
	  </tr>
	  % end
	</tbody>

    </div>      
  </div>
</div>

<script>
  $(document).ready( function () {
  $('#table_id').DataTable();
  } );
</script>

<style>

  .dataTables_length{
  width: 5em;
  }

  .dataTables_filter{
  width:15em;
  margin-left:-25em;
  }

  .dataTables_paginate{
  margin-left:-20em;
  }
</style>
