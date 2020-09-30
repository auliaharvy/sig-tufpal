<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('/login', 'Auth\LoginController@login');
Route::get('sendattachmentemail', 'API\TodayTransactionController@attachment_email');

Route::group(['middleware' => 'auth:api'], function() {
    Route::resource('sjp', 'SjpController');
    Route::post('/sjp/checktruck', 'SjpController@checkTruck');
    Route::resource('sjppalletsend', 'SjppalletsendController');
    Route::resource('sjppalletreceive', 'SjppalletreceiveController');
    Route::post('/sjp/adjust', 'SjpController@adjust');
    Route::post('/sjp/changedestination', 'SjpController@changedestination');
    Route::get('/sjpstatusbymaster/{id}', 'SjpStatusController@sjpstatusbymaster'); //get data untuk add sjp status
    Route::get('/view/{id}', 'SjpStatusController@view');
    Route::post('/sjp/cancel', 'SjpController@cancelled');

    Route::resource('sjpstatus', 'SjpStatusController');
    Route::post('/sjpstatus/sendingapproval', 'SjpStatusController@sendingdriverapproval');
    Route::post('/sjpstatus/sendback', 'SjpStatusController@sendback');
    Route::post('/sjpstatus/receive', 'SjpStatusController@receive');
    Route::post('/sjpstatus/receiveapproval', 'SjpStatusController@sendingdriverapproval');
    Route::post('/sjpstatus/receivesendback', 'SjpStatusController@receivesendback');

    Route::resource('pallettransfer', 'PalletTransferController');
    Route::resource('pallettransfersend', 'PallettransfersendController');
    Route::resource('pallettransferreceive', 'PallettransferreceiveController');

    Route::resource('transporteradjusment', 'TransporterAdjusmentController');

    Route::resource('bermissing', 'BermissingpalletController');
    Route::get('bermissing/view/{bmp_number}', 'BermissingpalletController@view');
    Route::post('/bermissing/disapprove', 'BermissingpalletController@disapprove');
    Route::resource('bermissingreported', 'BermissingpalletreportedController');
    Route::resource('bermissingapproved', 'BermissingpalletapprovedController');
    Route::resource('bermissingdisapproved', 'BermissingpalletdisapprovedController');

    Route::resource('newpallet', 'NewpalletController');
    Route::post('/newpallet/cancel', 'NewpalletController@newPalletCancel');
    Route::resource('damagedpallet', 'DamagedpalletController');
    Route::resource('repairedpallet', 'RepairedpalletController');
    Route::resource('palletmovement', 'PalletMovementController');
    Route::resource('alltransaction', 'AlltransactionController');
    Route::post('exportalltransaction', 'AlltransactionController@exportAllTransactionData');
    Route::resource('sjpadjusment', 'SjpadjusmentController');
    Route::resource('sjpchangedestination', 'SjpchangedestinationController');
    Route::resource('pool', 'PoolController');
    Route::get('poolform', 'PoolController@getpoolpallet');
    Route::get('poolautocomplete', 'PoolController@poolautocomplete');
    Route::resource('driver', 'DriverController');
    Route::get('driverform', 'DriverController@getdriverform');
    Route::resource('vehicle', 'VehicleController');
    Route::get('vehicleform', 'VehicleController@getvehicleform');
    Route::resource('transporter', 'TransporterController');
    Route::get('transporterform', 'TransporterController@gettransporters');
    Route::resource('msttransaction', 'MstTransactionController');
    Route::resource('organization', 'OrganizationController');
    Route::post('/pallettransfer/receive', 'PalletTransferController@receive');
    Route::post('/bermissing/approve', 'BermissingpalletController@approve');
    Route::resource('alltransaction', 'AlltransactionController');

    Route::post('/user/import', 'API\UserController@import');
    Route::post('getdispatch', 'DispatchDataController@dispatchData');


    Route::get('chart', 'API\DashboardController@chart');
    Route::get('chart2', 'API\DashboardController@chart2');
    Route::get('globalpallet', 'API\DashboardController@globalpallet');
    Route::get('pallet', 'API\DashboardController@pallet');
    Route::get('pallettransporter', 'API\DashboardController@palletTransporter');
    Route::get('poolpalletdetail', 'API\DashboardController@poolPalletDetail');
    Route::get('warehouseinout', 'API\DashboardController@warehouse_in_out');
    Route::get('transporterdetail', 'API\DashboardController@transporterDetail');
    Route::get('totalallpallet', 'API\DashboardController@totalAllPallet');
    Route::get('detailpoolpallet', 'API\DashboardController@detailPoolPallet');
    Route::get('detailtransporter', 'API\DashboardController@detailTransporter');
    Route::get('workshop', 'API\DashboardController@workshopInOut');
    Route::get('transportertopool', 'API\DashboardController@transporterToPool');

    Route::get('alltransactiontoday', 'API\TodayTransactionController@allTransactionToday');
    Route::get('exportalltransactiontoday', 'API\TodayTransactionController@exportData');
    Route::get('storealltransactiontoday', 'API\TodayTransactionController@storeData');
    // Route::get('sendattachmentemail', 'API\TodayTransactionController@attachment_email');
    Route::get('export', 'API\DashboardController@exportData');
    Route::resource('/outlets', 'API\OutletController')->except(['show']);

    Route::resource('/couriers', 'API\UserController')->except(['create', 'show', 'update']);
    Route::post('/couriers/{id}', 'API\UserController@update')->name('couriers.update');

    Route::resource('product', 'API\ProductController')->except(['create', 'show']);
    Route::get('/product/laundry-type', 'API\ProductController@getLaundryType');
    Route::post('/product/laundry-type', 'API\ProductController@storeLaundryType');

    Route::get('user-authenticated', 'API\UserController@getUserLogin')->name('user.authenticated');
    Route::get('user-lists', 'API\UserController@userLists')->name('user.index');
    Route::get('roles', 'API\RolePermissionController@getAllRole')->name('roles');
    Route::get('permissions', 'API\RolePermissionController@getAllPermission')->name('permission');
    Route::post('role-permission', 'API\RolePermissionController@getRolePermission')->name('role_permission');
    Route::post('set-role-permission', 'API\RolePermissionController@setRolePermission')->name('set_role_permission');
    Route::post('set-role-user', 'API\RolePermissionController@setRoleUser')->name('user.set_role');

    Route::resource('expenses', 'API\ExpensesController')->except(['create', 'show']);
    Route::post('expenses/accept', 'API\ExpensesController@accept')->name('expenses.accept');
    Route::post('expenses/cancel', 'API\ExpensesController@cancelRequest')->name('expenses.cancel');
    Route::resource('notification', 'API\NotificationController')->except(['create', 'destroy']);

    Route::resource('customer', 'API\CustomerController')->except(['create', 'show']);
    Route::resource('transaction', 'API\TransactionController')->except(['create', 'show']);
    Route::post('transaction/payment', 'API\TransactionController@makePayment');
    Route::post('transaction/complete-item', 'API\TransactionController@completeItem');
});
