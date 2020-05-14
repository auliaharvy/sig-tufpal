<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Newpallet;
use App\PoolPallet;
use App\Alltransaction;
use DB;

class NewpalletController extends Controller
{
    public function index()
    {
            $newpallet = DB::table('new_pallet as a')
            ->join('pool_pallet as b', 'a.pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('users as c', 'a.adder_user_id', '=', 'c.id')
            ->select('a.*', 'b.pool_name', 'c.name')
            ->paginate(10000000)
            ->toArray();
		 return $newpallet;
    }

    public function show($new_pallet_id)
    {
        $newpallet = Newpallet::find($new_pallet_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $newpallet]);
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1',
        ]);

        $new_pallet_id = $request->new_pallet_id;
        $pool_pallet_id = auth()->user()->reference_pool_pallet_id;

        DB::beginTransaction();
            try{
                $newpallet = Newpallet::create([
                    'adder_user_id' => auth()->user()->id,
                    'pool_pallet_id' => auth()->user()->reference_pool_pallet_id,
                    'good_pallet' => $request->good_pallet,
                    'vehicle' => $request->vehicle,
                    'driver' => $request->driver,
                    'vendor' => $request->vendor,
                    'note' => $request->note,
                ]);

                // Membuat log All Transaction
                    $reporter = Auth::user()->name;
                    $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
                    $transporter_id = Auth::user()->reference_transporter_id;
                    $newpalletreportpool = PoolPallet::find($pool_pallet_id);
                    // $bermissingreporttrans = Transporter::find($transporter_id);
                    $alltransaction = Alltransaction::create([
                        'reference_new_pallet_id' => $newpallet->new_pallet_id,
                        'transaction' => 'New Pallet Report',
                        'sender/reporter' => $reporter,
                        'status' => 'REPORTED',
                        'pool_pallet' => $newpalletreportpool->pool_name,
                        'good_pallet' => $newpallet->good_pallet,
                        'vehicle' => $newpallet->vehicle,
                        'driver' => $newpallet->driver,
                        'note' => $request->note,
                    ]);

                $InventoryPool = PoolPallet::find($pool_pallet_id);
                $InventoryPool->good_pallet = (($InventoryPool->good_pallet)+($request->good_pallet));
                $InventoryPool->save();

                DB::commit();
                return response()->json(['status' => 'success'], 200);
            }catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error',
                    'data' => $e->getMessage(),
                    'message' => 'Error New Pallet Pallet Record'], 422);
                }
    }

    public function destroy($id)
    {
        $newpallet = Newpallet::find($id); //QUERY DATA BERDASARKAN ID
        $newpallet->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
