package com.car.k1.model;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ModelVO {
    private int modelNo;                  					 // �𵨹�ȣ
    private String modelName;              				 // �𵨸�
    private String modelMake;             	 			 // ������
    private int modelYear;                 	 			 // ����
    private String modelImgStr;			  	 			 // �� �̹��� ���ϸ�
    private List<MultipartFile> modelImgList;  		 // �� �̹��� ���� ����Ʈ
    private List<String> imageNames;             		 // �� �̹��� ���ϸ� ����Ʈ
    private String modelDesc;              				 // �� ����
    private Date created;                   				 // �������

    // ������ ����
    private int totalCount;                // �� ������ ����
    private int startIdx;                  // �������� ���� �ε���
    private int endIdx;                    // �������� �� �ε���
    
    private String searchTitle;            // �˻� Ÿ��Ʋ
    private String searchValue;            // �˻� ��
}
