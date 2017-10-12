package com.gafker.www.security.message.digest.securityim;

import java.io.UnsupportedEncodingException;

/**
 * Base64... 对称加密算法（哈稀算法）：DES(DES,3DES),AES,IDEA,PBE 分类： 方向：双向 作用：频率最高加密算法。
 * 密钥：加密，解密的密钥相同 加密方式：密码和分组密码-（分组密码方式：ECB,CBC,CFB,OFB,CTR等）
 * 
 * @author gafker
 *
 */
public class ImSecDemo {
	private static final String CHARSET = "UTF-8";
	private static final String message = "welcome格式-Base64 format";

	public static void main(String[] args) throws UnsupportedEncodingException {
		// IM安全方案-Base64
		System.out.println("发送前内容:" + message);
		System.out.println("发送前内容转换成二进制:" + send(message));
		System.out.println("接收到的内容:" + receive(send(message)));

	}

	public static byte[] send(String message) throws UnsupportedEncodingException {
		return SecurityImBase64.encrypt(message.getBytes(CHARSET));
	}

	public static String receive(byte[] data) throws UnsupportedEncodingException {
		byte[] byteResult = SecurityImBase64.decrypt(data);
		return new String(byteResult, CHARSET);
	}

}
