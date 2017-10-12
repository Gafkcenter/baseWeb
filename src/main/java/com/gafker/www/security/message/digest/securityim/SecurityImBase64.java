package com.gafker.www.security.message.digest.securityim;

import org.apache.commons.codec.binary.Base64;

/**
 * Im Base64简单处理保证消息安全
 * 
 * @author gafker
 *
 */
public abstract class SecurityImBase64 {
	
	/**
	 * 
	 * @param data
	 *            待解密数据
	 * @return 解密返回数据 二进制byte[]
	 */
	public static byte[] decrypt(byte[] data) {
		return Base64.decodeBase64(data);
	}
	
	/**
	 * 
	 * @param data
	 *            待加密数据
	 * @return 加密返回数据Base64 byte[]
	 */
	public static byte[] encrypt(byte[] data) {
		return Base64.encodeBase64(data);
	}

}
