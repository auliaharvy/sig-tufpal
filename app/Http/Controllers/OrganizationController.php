<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Organization;
use App\PoolPallet;
use DB;

class OrganizationController extends Controller
{
    public function index()
    {
        $organization = DB::table('organization')
            ->paginate(1000000)
            ->toArray();
		 return $organization;
        // return response()->json(Sjp::all()->toArray());
    }

    public function store(Request $request)
    {

        $this->validate($request, [
            'organization_name' => 'required|string',
            'organization_address' => 'required|string',
        ]);

        DB::beginTransaction();
        try{
            $created_by = Auth::user()->name;
            $organization = Organization::create([
                'organization_name' => $request->organization_name,
                'organization_address' => $request->organization_address,
                'phone_number' => $request->phone_number,
                'organization_email' => $request->organization_email,
                'created_by' => $created_by
            ]);
            DB::commit();
            return response()->json(['status' => 'success'], 200);
        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Create Organization'], 422);
        }
    }

    public function edit($id)
    {
        $organization = Organization::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $organization]);
    }

    public function update(Request $request, $id)
    {
        //VALIDASI DATA YANG DITERIMA
        $this->validate($request, [
            'organization_name' => 'required|string',
            'organization_address' => 'required|string',
        ]);

        DB::beginTransaction();
        try{
            $created_by = Auth::user()->name;
            $update = Organization::find($id);
            $update->organization_id = $request->organization_id;
            $update->organization_name = $request->organization_name;
            $update->organization_address = $request->organization_address;
            $update->phone_number = $request->phone_number;
            $update->organization_email = $request->organization_email;
            $update->updated_by = $created_by;
            $update->save();
            DB::commit();
            return response()->json(['status' => 'success'], 200);
        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Update Organization Record'], 422);
        }
    }

    public function destroy($id)
    {
        $organization = Organization::find($id); //QUERY DATA BERDASARKAN ID
        $organization->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }

}
