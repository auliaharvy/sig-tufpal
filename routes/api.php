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

Route::group(['middleware' => 'auth:api'], function() {
    Route::resource('sjp', 'SjpController');
    Route::resource('sjppalletsend', 'SjppalletsendController');
    Route::resource('sjppalletreceive', 'SjppalletreceiveController');
    Route::post('/sjp/adjust', 'SjpController@adjust');
    Route::get('/sjpstatusbymaster/{id}', 'SjpStatusController@sjpstatusbymaster'); //get data untuk add sjp status
    Route::resource('sjpstatus', 'SjpStatusController');
    Route::post('/sjpstatus/sendback', 'SjpStatusController@sendback');
    Route::post('/sjpstatus/receive', 'SjpStatusController@receive');
    Route::post('/sjpstatus/receivesendback', 'SjpStatusController@receivesendback');
    Route::resource('pallettransfer', 'PalletTransferController');
    Route::resource('pallettransfersend', 'PalletTransfersendController');
    Route::resource('pallettransferreceive', 'PalletTransferreceiveController');  
    Route::resource('bermissing', 'BermissingpalletController');
    Route::resource('bermissingreported', 'BermissingpalletreportedController');
    Route::resource('bermissingapproved', 'BermissingpalletapprovedController');
    Route::resource('newpallet', 'NewpalletController');
    Route::resource('damagedpallet', 'DamagedpalletController');
    Route::resource('repairedpallet', 'RepairedpalletController');
    Route::resource('palletmovement', 'PalletMovementController');
    Route::resource('sjpadjusment', 'SjpadjusmentController');
    Route::resource('pool', 'PoolController');
    Route::get('poolform', 'PoolController@getpoolpallet');
    Route::resource('driver', 'DriverController');
    Route::get('driverform', 'DriverController@getdriverform');
    Route::resource('vehicle', 'VehicleController');
    Route::get('vehicleform', 'VehicleController@getvehicleform');
    Route::resource('transporter', 'TransporterController');
    Route::resource('msttransaction', 'MstTransactionController');
    Route::resource('organization', 'OrganizationController');
    Route::post('/pallettransfer/receive', 'PalletTransferController@receive');
    Route::post('/bermissing/approve', 'BermissingpalletController@approve');


    Route::get('chart', 'API\DashboardController@chart');
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