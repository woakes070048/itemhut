<!-- This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/. -->

% rebase('global/base.tpl')

<div class="expanded row">
  <div class="medium-2 columns">
    <h4>Warehouses</h4>
    <ul class="vertical menu">
      % for i in wh:
      % if i[2] == 'B&M':
      <li><a href = "/warehouses/{{i[0]}}">{{i[1]}}</a></li>
      % end
      % end
    </ul>

    <h4>3PL</h4>
    <ul class="vertical menu">
      % for i in wh:
      % if i[2] == '3PL':
      <li><a href = "/warehouses/{{i[0]}}">{{i[1]}}</a></li>
      % end
      % end
    </ul>
    <h4>Base Management</h4>
    <ul class="vertical menu">
      <li><a href = "/warehouses/cases">Cases & Boxes</a></li>
    </ul>
  </div>

  <div class="medium-10 columns">
    <h4>Running Inventory (All Warehouses)</h4>
    <table id="table_id" class="display">
      <thead>
	<tr>
	  % for h in ["SKU", "UPC", "Qty"]:
	  <th>{{h}}</th>
	  % end
	</tr>
      </thead>
      <tbody>
	% for i in running_inventory:
	<tr>
	  <td>{{i[0]}}</td>
	  <td>{{i[1]}}</td>
	  <td>{{i[2]}}</td>
	</tr>
	% end
      </tbody>
    </table>
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
  margin-left:-10em;
  }
</style>
