<?php

namespace App\Http\Controllers;

use Log;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use App\Payload;

class AccountController extends Controller
{
    /**
     * View an account in detail.
     *
     * @param  Request  $request
     * @param  string   $username
     * @return Response
     */
    public function detail(Request $request, string $username)
    {
        // create the response payload with default HTTP response code 200
        $resPayload = new Payload(JsonResponse::HTTP_OK);
        $continue = true;

        // check the required parameter
        if (!$username) {
            $resPayload->code = JsonResponse::HTTP_BAD_REQUEST;
            $resPayload->message = 'incorrent request.';
            $continue = false;
        }

        $targetAccount = null;
        // find the targeted account (based on the username parameter)
        if ($continue) {
            $targetAccount = DB::table('account')
            ->where('username', $username)
            ->first();
            
            if (!$targetAccount) {
                $resPayload->code = 400;
                $resPayload->message = 'incorrent request.';
                $continue = false;
            }
        }
        
        $account = null;
        // check the token validity
        if ($continue) {
            $token = $this->getToken($request);
            if ($token) {
                $account = DB::table('account')
                ->where('token', $token)
                ->first();
            }
        }

        if ($continue) {
            // HATEOAS
            $targetAccount->account_uri = "/accounts/{$targetAccount->username}";

            if ($account->token != $targetAccount->token) {
                unset($targetAccount->balance);
            } else {
                $targetAccount->transactions_uri = "/transactions";
            }
            unset($targetAccount->token);

            $resPayload->data = $targetAccount;
        }

        // create the response object based on the response payload
        $response = new JsonResponse($resPayload, $resPayload->code);

        return($response);
    }
    
    /**
     * Update an existing account.
     * This API accepts a request with valid authorization token with JSON formatted (updated) data.
     *
     * @param  Request  $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        // create the response object based on the response payload
        $response = new JsonResponse(null, JsonResponse::HTTP_NOT_IMPLEMENTED);

        return($response);
    }
}
