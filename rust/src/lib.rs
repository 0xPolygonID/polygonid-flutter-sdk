// WARNING still updating the code, it works, but is still in process the refactor.

pub mod eddsa;

use poseidon_rs::Poseidon;
pub type Fr = poseidon_rs::Fr;

extern crate ff;

#[macro_use]
extern crate arrayref;
extern crate generic_array;
//extern crate mimc_rs;
extern crate num;
extern crate num_bigint;
extern crate num_traits;
extern crate rand6;
extern crate rand;
extern crate blake; // compatible version with Blake used at circomlib
#[macro_use]
extern crate lazy_static;

use ff::*;

use crate::eddsa::{Signature, decompress_point, Point, PrivateKey, verify, decompress_signature};
use num_bigint::{Sign, BigInt};
use std::convert::TryInto;
use std::os::raw::{c_char};
use std::ffi::{CStr, CString};
use std::cmp::min;
use std::str::FromStr;
use rustc_hex::{FromHex, ToHex};
use std::panic::catch_unwind;

/*lazy_static! {
 static ref B8: Point = Point {
        x: Fr::from_str(
            "5299619240641551281634865583518297030282874472190772894086521144482721001553",
        )
        .unwrap(),
        y: Fr::from_str(
            "16950150798460657717958625567821834550301663161624707787222815936182638968203",
        )
        .unwrap(),
        // z: Fr::one(),
    };
}*/

#[no_mangle]
pub /*extern*/ fn pack_signature_internal(signature: *const c_char) -> *mut c_char {
    let signature_cstr = unsafe { CStr::from_ptr(signature) };
    let signature_str = match signature_cstr.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let signature_bytes_raw = signature_str.from_hex().unwrap();
    let mut signature_bytes: [u8; 64] = [0; 64];
    signature_bytes.copy_from_slice(&signature_bytes_raw);

    let r_b8_bytes: [u8; 32] = *array_ref!(signature_bytes[..32], 0, 32);
    let s: BigInt = BigInt::from_bytes_le(Sign::Plus, &signature_bytes[32..]);

    //let x_big = BigInt::parse_bytes(&r_b8_bytes[..16], 16).unwrap();
    //let y_big = BigInt::parse_bytes(&r_b8_bytes[16..], 16).unwrap();
    /*let (_, x_bytes) = x_big.to_bytes_le();
    let (_, y_bytes) = y_big.to_bytes_le();

    let mut x_16bytes: [u8; 16] = [0; 16];
    let lenx = min(x_bytes.len(), x_16bytes.len());
    x_16bytes[..lenx].copy_from_slice(&x_bytes[..lenx]);
    b.append(&mut x_16bytes.to_vec());

    let mut y_16bytes: [u8; 16] = [0; 16];
    let leny = min(y_bytes.len(), y_16bytes.len());
    y_16bytes[..leny].copy_from_slice(&y_bytes[..leny]);
    b.append(&mut y_16bytes.to_vec());*/


    //let x_string = to_hex_string(r_b8_bytes[..16].to_vec());
    //let x_str = x_string.as_str();
    //let y_string = to_hex_string(r_b8_bytes[16..].to_vec());

    //let r_b8 = decompress_point(r_b8_bytes).unwrap();
    //let y_str = y_string.as_str();
    //let x_big = BigInt::parse_bytes(&r_b8_bytes[0..15], 16).unwrap();
    //let y_big = BigInt::parse_bytes(&r_b8_bytes[15..32], 16).unwrap();
    let x_big: BigInt = BigInt::from_bytes_le(Sign::Plus, &r_b8_bytes[0..15]);
    let y_big: BigInt = BigInt::from_bytes_le(Sign::Plus, &r_b8_bytes[15..32]);
    //let y_big = x_big.clone();

    let x:Fr = Fr::from_str(
            &x_big.to_string(),
        ).unwrap();

    let y:Fr = Fr::from_str(
            &y_big.to_string(),
        ).unwrap();

    let r_b8: Point = Point {
        x: x,
        y: y,
    };

    let sig = Signature { r_b8 : r_b8.clone(), s };
    let res = sig.compress();

    let hex_string = to_hex_string(res.to_vec());
    CString::new(hex_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn pack_signature(signature: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| pack_signature_internal(signature));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("pack_signature Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

#[no_mangle]
pub /*extern*/ fn unpack_signature_internal(compressed_signature: *const c_char) -> *mut c_char {
    let compressed_signature_cstr = unsafe { CStr::from_ptr(compressed_signature) };
    let compressed_signature_str = match compressed_signature_cstr.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let compressed_signature_bytes_raw = compressed_signature_str.from_hex().unwrap();
    let mut compressed_signature_bytes: [u8; 64] = [0; 64];
    compressed_signature_bytes.copy_from_slice(&compressed_signature_bytes_raw);
    let decompressed_sig = decompress_signature(&compressed_signature_bytes).unwrap();

    let mut b: Vec<u8> = Vec::new();

    let x_big = BigInt::parse_bytes(to_hex(&decompressed_sig.r_b8.x).as_bytes(), 16).unwrap();
    let y_big = BigInt::parse_bytes(to_hex(&decompressed_sig.r_b8.y).as_bytes(), 16).unwrap();
    let (_, x_bytes) = x_big.to_bytes_le();
    let (_, y_bytes) = y_big.to_bytes_le();

    let mut x_16bytes: [u8; 16] = [0; 16];
    let lenx = min(x_bytes.len(), x_16bytes.len());
    x_16bytes[..lenx].copy_from_slice(&x_bytes[..lenx]);
    b.append(&mut x_16bytes.to_vec());

    let mut y_16bytes: [u8; 16] = [0; 16];
    let leny = min(y_bytes.len(), y_16bytes.len());
    y_16bytes[..leny].copy_from_slice(&y_bytes[..leny]);
    b.append(&mut y_16bytes.to_vec());

    let (_, s_bytes) = decompressed_sig.s.to_bytes_le();
    let mut s_32bytes: [u8; 32] = [0; 32];
    let lens = min(s_bytes.len(), s_32bytes.len());
    s_32bytes[..lens].copy_from_slice(&s_bytes[..lens]);
    b.append(&mut s_32bytes.to_vec());

    let mut r: [u8; 64] = [0; 64];
    let res_len = min(r.len(), b.len());
    r[..res_len].copy_from_slice(&b[..res_len]);

    let hex_string = to_hex_string(r.to_vec());
    CString::new(hex_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn unpack_signature(compressed_signature: *const c_char) -> *mut c_char {
    println!("Rust unpack_signature");
    let result = catch_unwind(|| unpack_signature_internal(compressed_signature));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("unpack_signature Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

#[no_mangle]
pub /*extern*/ fn pack_point_internal(point_x: *const c_char, point_y: *const c_char) -> *mut c_char {
    let point_x_cstr = unsafe { CStr::from_ptr(point_x) };
    let point_x_str = match point_x_cstr.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let point_y_cstr = unsafe { CStr::from_ptr(point_y) };
    let point_y_str = match point_y_cstr.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let p: Point = Point {
        x: Fr::from_str(point_x_str).unwrap(),
        y: Fr::from_str(point_y_str).unwrap(),
    };

    let compressed_point = p.compress();
    let hex_string = to_hex_string(compressed_point.to_vec());
    CString::new(hex_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn pack_point(point_x: *const c_char, point_y: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| pack_point_internal(point_x, point_y));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("pack_point Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

pub fn to_hex_string(bytes: Vec<u8>) -> String {
    let strs: Vec<String> = bytes.iter()
        .map(|b| format!("{:02X}", b))
        .collect();
    strs.join("")
}

#[no_mangle]
pub /*extern*/ fn unpack_point_internal(compressed_point: *const c_char) ->  *mut c_char {
    let compressed_point_str = unsafe { CStr::from_ptr(compressed_point) }.to_str().unwrap();
    let y_bytes_raw = compressed_point_str.from_hex().unwrap();
    let mut y_bytes: [u8; 32] = [0; 32];
    y_bytes.copy_from_slice(&y_bytes_raw);
    let p = decompress_point(y_bytes).unwrap();
    let x_big = BigInt::parse_bytes(to_hex(&p.x).as_bytes(), 16).unwrap();
    let y_big = BigInt::parse_bytes(to_hex(&p.y).as_bytes(), 16).unwrap();
    let mut result_string: String = "".to_owned();
    result_string.push_str(&x_big.to_string());
    result_string.push_str(",");
    result_string.push_str(&y_big.to_string());
    CString::new(result_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn unpack_point(compressed_point: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| unpack_point_internal(compressed_point));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("unpack_point Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

#[no_mangle]
pub /*extern*/ fn prv2pub_internal(private_key: *const c_char) -> *mut c_char {
    /*let private_key_bytes: [u8; 32] = *array_ref!(private_key[..32], 0, 32);
    let private_key = PrivateKey::import(private_key_bytes.to_vec()).unwrap();*/
    let private_key_str = unsafe { CStr::from_ptr(private_key) }.to_str().unwrap();
    //let pk_bigint = BigInt::from_str(private_key_str).unwrap();
    let pk_bytes_raw = private_key_str.from_hex().unwrap();
    let mut pk_bytes: [u8; 32] = [0; 32];
    pk_bytes.copy_from_slice(&pk_bytes_raw);
    let pk = PrivateKey { key: pk_bytes };
    let public_key = pk.public();
    let mut result_string: String = "".to_owned();
    result_string.push_str(&public_key.x.to_string());
    result_string.push_str(",");
    result_string.push_str(&public_key.y.to_string());
    CString::new(result_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn prv2pub(private_key: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| prv2pub_internal(private_key));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("prv2pub Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}


#[no_mangle]
pub /*extern*/ fn poseidon_hash_internal(input: *const c_char) -> *mut c_char {

    let input_str = unsafe { CStr::from_ptr(input) }.to_str().unwrap();
    let b0: Fr = Fr::from_str(input_str).unwrap();

    let hm_input = vec![b0.clone()];
    //let hm_input = vec![x.clone(), y.clone(), z.clone()];
    let poseidon = Poseidon::new();
    let hm = poseidon.hash(hm_input).unwrap();
    //hm.to_string: Fr(0x29176100eaa962bdc1fe6c654d6a3c130e96a4d1168b33848b897dc502820133)
    return CString::new(to_hex(&hm).as_str()).unwrap().into_raw();
    //return CString::new(hm.to_string()).unwrap().into_raw();
}

#[no_mangle]
pub extern fn poseidon_hash(input: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| poseidon_hash_internal(input));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("poseidon_hash Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

#[no_mangle]
pub extern "C" fn poseidon_hash2_internal(input1: *const c_char, input2: *const c_char) -> *mut c_char {
    let input_str1 = unsafe { CStr::from_ptr(input1) }.to_str().unwrap();
    let input_str2 = unsafe { CStr::from_ptr(input2) }.to_str().unwrap();

    let b1: Fr = Fr::from_str(input_str1).unwrap();
    let b2: Fr = Fr::from_str(input_str2).unwrap();

    let hm_input = vec![b1.clone(), b2.clone()];

    let poseidon = Poseidon::new();
    let hm = poseidon.hash(hm_input).unwrap();

    return CString::new(to_hex(&hm).as_str()).unwrap().into_raw();
}

#[no_mangle]
pub extern "C" fn poseidon_hash2(input1: *const c_char, input2: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| poseidon_hash2_internal(input1, input2));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("poseidon_hash2 Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

#[no_mangle]
pub extern "C" fn poseidon_hash3_internal(input1: *const c_char, input2: *const c_char, input3: *const c_char) -> *mut c_char {
    let input_str1 = unsafe { CStr::from_ptr(input1) }.to_str().unwrap();
    let input_str2 = unsafe { CStr::from_ptr(input2) }.to_str().unwrap();
    let input_str3 = unsafe { CStr::from_ptr(input3) }.to_str().unwrap();

    let b1: Fr = Fr::from_str(input_str1).unwrap();
    let b2: Fr = Fr::from_str(input_str2).unwrap();
    let b3: Fr = Fr::from_str(input_str3).unwrap();

    let hm_input = vec![b1.clone(), b2.clone(), b3.clone()];

    let poseidon = Poseidon::new();
    let hm = poseidon.hash(hm_input).unwrap();

    return CString::new(to_hex(&hm).as_str()).unwrap().into_raw();
}

#[no_mangle]
pub extern "C" fn poseidon_hash3(input1: *const c_char, input2: *const c_char, input3: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| poseidon_hash3_internal(input1, input2, input3));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("poseidon_hash3 Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

#[no_mangle]
pub extern "C" fn poseidon_hash4_internal(input1: *const c_char, input2: *const c_char, input3: *const c_char, input4: *const c_char) -> *mut c_char {
    let input_str1 = unsafe { CStr::from_ptr(input1) }.to_str().unwrap();
    let input_str2 = unsafe { CStr::from_ptr(input2) }.to_str().unwrap();
    let input_str3 = unsafe { CStr::from_ptr(input3) }.to_str().unwrap();
    let input_str4 = unsafe { CStr::from_ptr(input4) }.to_str().unwrap();

    let b1: Fr = Fr::from_str(input_str1).unwrap();
    let b2: Fr = Fr::from_str(input_str2).unwrap();
    let b3: Fr = Fr::from_str(input_str3).unwrap();
    let b4: Fr = Fr::from_str(input_str4).unwrap();

    let hm_input = vec![b1.clone(), b2.clone(), b3.clone(), b4.clone()];

    let poseidon = Poseidon::new();
    let hm = poseidon.hash(hm_input).unwrap();

    return CString::new(to_hex(&hm).as_str()).unwrap().into_raw();
}

#[no_mangle]
pub extern "C" fn poseidon_hash4(input1: *const c_char, input2: *const c_char, input3: *const c_char, input4: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| poseidon_hash4_internal(input1, input2, input3, input4));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("poseidon_hash4 Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}


#[no_mangle]
//pub extern fn hash_poseidon(tx_compressed_data: *const c_char, to_eth_addr: *const c_char, to_bjj_ay: *const c_char, rq_txcompressed_data_v2: *const c_char, rq_to_eth_addr: *const c_char, rq_to_bjj_ay: *const c_char) -> *mut c_char {
pub /*extern*/ fn hash_poseidon_internal(claims_tree: *const c_char, revocation_tree: *const c_char, roots_tree_root: *const c_char) -> *mut c_char {
    //let claims_tree_str = unsafe { CStr::from_ptr(claims_tree) }.to_str().unwrap();
    //let claims_tree_bigint = match claims_tree_str.parse::<i32>() {
    //        Ok(n) => BigInt::from(n),
    //        Err(e) => BigInt::zero(),
    //    };
    //let b0: Fr = Fr::from_str(
    //                &claims_tree_bigint.to_string(),
    //            ).unwrap();

    //let revocation_tree_str = unsafe { CStr::from_ptr(revocation_tree) }.to_str().unwrap();
    //let revocation_tree_bigint = match revocation_tree_str.parse::<i32>() {
    //            Ok(n) => BigInt::from(n),
    //            Err(e) => BigInt::zero(),
    //        };
    //let b1: Fr = Fr::from_str(
    //                &revocation_tree_bigint.to_string(),
    //                ).unwrap();

    //let roots_tree_root_str = unsafe { CStr::from_ptr(roots_tree_root) }.to_str().unwrap();
    //    let roots_tree_root_bigint = match roots_tree_root_str.parse::<i32>() {
    //                Ok(n) => BigInt::from(n),
    //                Err(e) => BigInt::zero(),
    //            };
    //    let b2: Fr = Fr::from_str(
    //                    &roots_tree_root_bigint.to_string(),
    //                    ).unwrap();

     //let x: Fr = Fr::from_str(
     //            "4648350302718598839424502774166524253703556728225603109003078358379460427828",
     //        ).unwrap();
     //let x: Fr = Fr::from_str(
     //                 "23520646440406697341854711669252473191475099932451150382882460752222516889098").unwrap();
     //let y: Fr = Fr::zero();
     //let z: Fr = Fr::zero();

    let claims_tree_str = unsafe { CStr::from_ptr(claims_tree) }.to_str().unwrap();
    let b0: Fr = Fr::from_str(claims_tree_str).unwrap();

    let revocation_tree_str = unsafe { CStr::from_ptr(revocation_tree) }.to_str().unwrap();
    let b1: Fr = Fr::from_str(revocation_tree_str).unwrap();

    let roots_tree_root_str = unsafe { CStr::from_ptr(roots_tree_root) }.to_str().unwrap();
    let b2: Fr = Fr::from_str(roots_tree_root_str).unwrap();

    //if to_eth_addr.is_null() {
    //    let to_eth_addr_str = unsafe { CStr::from_ptr(to_eth_addr) }.to_str().unwrap();
    //    let b1: Fr = Fr::from_str(to_eth_addr_str).unwrap();
    //    let mut b1_input = vec![b1.clone()];
    //    hm_input.append(&mut b1_input);
    //}

    //if to_bjj_ay.is_null() {
    //    let to_bjj_ay_str = unsafe { CStr::from_ptr(to_bjj_ay) }.to_str().unwrap();
    //    let b2: Fr = Fr::from_str(to_bjj_ay_str).unwrap();
    //    let mut b2_input = vec![b2.clone()];
    //    hm_input.append(&mut b2_input);
    //}

    //if rq_txcompressed_data_v2.is_null() {
    //    let rq_txcompressed_data_v2_str = unsafe { CStr::from_ptr(rq_txcompressed_data_v2) }.to_str().unwrap();
    //    let b3: Fr = Fr::from_str(rq_txcompressed_data_v2_str).unwrap();
    //    let mut b3_input = vec![b3.clone()];
    //    hm_input.append(&mut b3_input);
    //}

    //if rq_to_eth_addr.is_null() {
    //    let rq_to_eth_addr_str = unsafe { CStr::from_ptr(rq_to_eth_addr) }.to_str().unwrap();
    //    let b4: Fr = Fr::from_str(rq_to_eth_addr_str).unwrap();
    //    let mut b4_input = vec![b4.clone()];
    //    hm_input.append(&mut b4_input);
    //}

    //if rq_to_bjj_ay.is_null() {
    //    let rq_to_bjj_ay_str = unsafe { CStr::from_ptr(rq_to_bjj_ay) }.to_str().unwrap();
    //    let b5: Fr = Fr::from_str(rq_to_bjj_ay_str).unwrap();
    //    let mut b5_input = vec![b5.clone()];
    //    hm_input.append(&mut b5_input);
    //}

    let hm_input = vec![b0.clone(), b1.clone(), b2.clone()];
    //let hm_input = vec![x.clone(), y.clone(), z.clone()];
    let poseidon = Poseidon::new();
    let hm = poseidon.hash(hm_input).unwrap();
    return CString::new(to_hex(&hm).as_str()).unwrap().into_raw();
}


#[no_mangle]
pub extern fn hash_poseidon(claims_tree: *const c_char, revocation_tree: *const c_char, roots_tree_root: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| hash_poseidon_internal(claims_tree, revocation_tree, roots_tree_root));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("hash_poseidon Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

#[no_mangle]
pub /*extern*/ fn sign_poseidon_internal(private_key: *const c_char, msg: *const c_char) -> *mut c_char {
    let private_key_str = unsafe { CStr::from_ptr(private_key) }.to_str().unwrap();
    //let pk_bigint = BigInt::from_str(private_key_str).unwrap();
    let pk_bytes_raw = private_key_str.from_hex().unwrap();
    let mut pk_bytes: [u8; 32] = [0; 32];
    pk_bytes.copy_from_slice(&pk_bytes_raw);
    let pk = PrivateKey { key: pk_bytes };
    let message_str = unsafe { CStr::from_ptr(msg) }.to_str().unwrap();
    let message_bigint = BigInt::from_str(message_str).unwrap();
    let sig = pk.sign(message_bigint.clone()).unwrap();
    let compressed_signature = sig.compress();
    let hex_string = compressed_signature.to_hex();
    CString::new(hex_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn sign_poseidon(private_key: *const c_char, msg: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| sign_poseidon_internal(private_key, msg));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("sign_poseidon Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

fn bytes_from_str(s: *const c_char) -> Result<Vec<u8>, String> {
    if s.is_null() {
        return Err("str pointer is null".to_owned());
    };
    let s = unsafe { CStr::from_ptr(s) }.to_str()
        .map_err(|e| format!("utf8 string error: {}", e.to_string()))?;
    s.from_hex().map_err(|e| format!("hex decode error: {}", e.to_string()))
}

fn bigint_from_str(s: *const c_char) -> Result<BigInt, String> {
    if s.is_null() {
        return Err("str pointer is null".to_owned());
    };
    let s = unsafe { CStr::from_ptr(s) }.to_str()
        .map_err(|e| format!("utf8 string error: {}", e.to_string()))?;
    BigInt::from_str(s).map_err(|e| format!("bigint parse error: {}", e.to_string()))
}

fn priv_key(private_key: *const c_char) -> Result<PrivateKey, String> {
    let pk_bytes = bytes_from_str(private_key).map_err(|e| format!("private key error: {}", e))?;
    Ok(PrivateKey { key: pk_bytes.try_into()
        .map_err(|_| "private key should be exactly 32 bytes long".to_owned())? })
}

fn unpack_sig(compressed_signature: *const c_char) -> Result<Signature, String> {
    let signature_bytes = bytes_from_str(compressed_signature)
        .map_err(|e| format!("signature error: {}", e.to_string()))?;
    let signature_bytes: [u8; 64] = signature_bytes.try_into()
        .map_err(|_| "signature should be exactly 64 bytes long".to_owned())?;
    decompress_signature(&signature_bytes)
}

#[no_mangle]
pub fn verify_poseidon_internal(private_key: *const c_char, compressed_signature: *const c_char, message: *const c_char) ->  *mut c_char {
    let pk = priv_key(private_key)
        .unwrap_or_else(|err_msg| panic!("{}", err_msg));
    let sig = unpack_sig(compressed_signature)
        .unwrap_or_else(|err_msg| panic!("{}", err_msg));
    let message_bigint = bigint_from_str(message)
        .unwrap_or_else(|err_msg| panic!("message parse error: {}", err_msg));

    if verify(pk.public(), sig, message_bigint) {
        CString::new("1".to_owned()).unwrap().into_raw()
    } else {
        CString::new("0".to_owned()).unwrap().into_raw()
    }
}


#[no_mangle]
pub extern fn verify_poseidon(private_key: *const c_char, compressed_signature: *const c_char, message: *const c_char) -> *mut c_char {
    let result = catch_unwind(|| verify_poseidon_internal(private_key, compressed_signature, message));
    match result {
        Ok(res) => res,
        Err(e) => {
            println!("verify_poseidon Rust Err: {:?}", e);
            std::ptr::null_mut()
        }
    }
}

#[no_mangle]
pub extern fn cstring_free(str: *mut c_char) {
    unsafe {
        if str.is_null() { return }
        drop(CString::from_raw(str));
    };
}

#[cfg(test)]
mod tests {
    use std::ptr::null;
    use super::*;

    #[test]
    #[should_panic(expected = "private key error: str pointer is null")]
    fn test_verify_poseidon_internal_with_null_private_key_should_panic() {
        verify_poseidon_internal(null(), null(), null());
    }

    #[test]
    fn test_verify_poseidon_with_null_private_key_should_panic() {
        let x = verify_poseidon(null(), null(), null());
        assert!(x.is_null());
    }

    #[test]
    #[should_panic(expected = "private key error: hex decode error: Invalid character 'p' at position 0")]
    fn test_verify_poseidon_internal_with_incorrect_hex_private_key_should_panic() {
        let pk = CString::new("pk").unwrap();
        verify_poseidon_internal(pk.into_raw(), null(), null());
    }

    #[test]
    #[should_panic(expected = "signature error: str pointer is null")]
    fn test_verify_poseidon_null_sig() {
        let pk = CString::new("459a964f864b613e0fae29bd5395cb7e5cb16d9501d898a5630d25dc56ab87aa").unwrap();
        let msg = CString::new("184467440737095516150").unwrap();
        verify_poseidon_internal(pk.into_raw(), null(), msg.into_raw());
    }

    #[test]
    #[should_panic(expected = "message parse error: str pointer is null")]
    fn test_verify_poseidon_null_msg() {
        let pk = CString::new("459a964f864b613e0fae29bd5395cb7e5cb16d9501d898a5630d25dc56ab87aa").unwrap();
        let sig = CString::new("aac24e561679c387a075ea22a153d8d060ee751555da44484f96ef3721537c9cf436f9668439cc183382a0ec1445ca594c8b626041bba1c28870c318e41cb305").unwrap();
        verify_poseidon_internal(pk.into_raw(), sig.into_raw(), null());
    }

    #[test]
    fn test_verify_poseidon_ok() {
        let pk = CString::new("459a964f864b613e0fae29bd5395cb7e5cb16d9501d898a5630d25dc56ab87aa").unwrap();
        let sig = CString::new("aac24e561679c387a075ea22a153d8d060ee751555da44484f96ef3721537c9cf436f9668439cc183382a0ec1445ca594c8b626041bba1c28870c318e41cb305").unwrap();
        let msg = CString::new("184467440737095516150").unwrap();
        let r = verify_poseidon(pk.into_raw(), sig.into_raw(), msg.into_raw());

        let r = unsafe { CStr::from_ptr(r) }.to_str().unwrap();
        assert_eq!(r, "1");
    }

    #[test]
    fn test_verify_poseidon_invalid_sig() {
        let pk = CString::new("459a964f864b613e0fae29bd5395cb7e5cb16d9501d898a5630d25dc56ab87aa").unwrap();
        let sig = CString::new("aac24e561679c387a075ea22a153d8d060ee751555da44484f96ef3721537c9cf436f9668439cc183382a0ec1445ca594c8b626041bba1c28870c318e41cb307").unwrap();
        let msg = CString::new("184467440737095516150").unwrap();
        let r = verify_poseidon(pk.into_raw(), sig.into_raw(), msg.into_raw());

        let r = unsafe { CStr::from_ptr(r) }.to_str().unwrap();
        assert_eq!(r, "0");
    }

    #[test]
    #[should_panic(expected = "message parse error: bigint parse error: invalid digit found in string")]
    fn test_verify_poseidon_internal_invalid_msg() {
        let pk = CString::new("459a964f864b613e0fae29bd5395cb7e5cb16d9501d898a5630d25dc56ab87aa").unwrap();
        let sig = CString::new("aac24e561679c387a075ea22a153d8d060ee751555da44484f96ef3721537c9cf436f9668439cc183382a0ec1445ca594c8b626041bba1c28870c318e41cb307").unwrap();
        let msg = CString::new("abc").unwrap();
        verify_poseidon_internal(pk.into_raw(), sig.into_raw(), msg.into_raw());
    }

    #[test]
    #[should_panic(expected = "signature should be exactly 64 bytes long")]
    fn test_verify_poseidon_internal_sig_len_error() {
        let pk = CString::new("459a964f864b613e0fae29bd5395cb7e5cb16d9501d898a5630d25dc56ab87aa").unwrap();
        let sig = CString::new("aac24e561679c387a075ea22a153d8d060ee751555da44484f96ef3721537c9cf436f9668439cc183382a0ec1445ca594c8b626041bba1c28870c318e41cb3").unwrap();
        let msg = CString::new("abc").unwrap();
        verify_poseidon_internal(pk.into_raw(), sig.into_raw(), msg.into_raw());
    }

    #[test]
    // #[should_panic(expected = "signature should be exactly 64 bytes long")]
    fn test_verify_poseidon_sig_len_error() {
        let pk = CString::new("459a964f864b613e0fae29bd5395cb7e5cb16d9501d898a5630d25dc56ab87aa").unwrap();
        let sig = CString::new("aac24e561679c387a075ea22a153d8d060ee751555da44484f96ef3721537c9cf436f9668439cc183382a0ec1445ca594c8b626041bba1c28870c318e41cb3").unwrap();
        let msg = CString::new("abc").unwrap();
        let r = verify_poseidon(pk.into_raw(), sig.into_raw(), msg.into_raw());
        assert_eq!(std::ptr::null_mut(), r);
    }
}