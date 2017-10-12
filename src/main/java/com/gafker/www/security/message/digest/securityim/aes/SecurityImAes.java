package com.gafker.www.security.message.digest.securityim.aes;

import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;

/**
 * Im Base64简单处理保证消息安全
 * 
 * @author gafker
 *
 */
public abstract class SecurityImAes {

	// 密钥算法
	public static final String ALGORITHM = "AES";
	// 密钥
	private static final String KEY = "1486c514861486c514861486c514861486c514861486c514861486c514861486c514861486c514861486c514861486c514861486c514861486c514861486c514";

	/**
	 * 转换解密的对称密钥
	 * 
	 * @return
	 * @throws DecoderException
	 */
	private static Key getKey() throws DecoderException {
		byte[] key = Hex.decodeHex(KEY.toCharArray());
		// 社会化AES密钥材料
		SecretKey secretKey = new SecretKeySpec(key, ALGORITHM);
		return secretKey;
	}
	
	/**
	 * 
	 * @param data
	 *            待解密数据
	 * @return 解密返回数据 二进制byte[]
	 */
	public static byte[] decrypt(byte[] data) {
		try {
			//实例化
			Cipher cipher = Cipher.getInstance(ALGORITHM);
			//初始化，设置为解密模式
			cipher.init(Cipher.DECRYPT_MODE, getKey());
			//执行操作
			return cipher.doFinal(data);
		} catch (Exception e) {
			return data;
		}
	}

	/**
	 * 
	 * @param data
	 *            待加密数据
	 * @return 加密返回数据Base64 byte[]
	 */
	public static byte[] encrypt(byte[] data){
		try {
			//实例化
			Cipher cipher = Cipher.getInstance(ALGORITHM);
			//初始化，设置为加密模式
			cipher.init(Cipher.ENCRYPT_MODE, getKey());
			//执行操作
			return cipher.doFinal(data);
		} catch (Exception e) {
			return data;
		}
	}

	/**
	 * 生成密钥：AES内部密钥
	 * 
	 * @return 二进制密钥
	 * @throws NoSuchAlgorithmException
	 */
	public static byte[] initKey() throws NoSuchAlgorithmException {
		// 实例化
		KeyGenerator kg = KeyGenerator.getInstance(ALGORITHM);
		// key长度
		kg.init(256);
		// 生成秘密密钥
		SecretKey secretKey = kg.generateKey();
		// 获得密钥的二进制编码形式
		return secretKey.getEncoded();
	}

	/**
	 * 生成密钥
	 * 
	 * @return String 十六进制字符串
	 * @throws NoSuchAlgorithmException
	 */
	public static String initKeyHex() throws NoSuchAlgorithmException {
		return Hex.encodeHexString(initKey());
	}
}
