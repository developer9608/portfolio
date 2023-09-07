package com.car.k1.member;

import java.util.Date;
import lombok.Data;

@Data
public class MemberVO {
    private int memberNo;                   // ȸ�� ��ȣ
    private String memberName;              // ȸ�� �̸�
    private String memberLoginId;           // ȸ�� �α��� ���̵�
    private String memberPassword;          // ȸ�� ��й�ȣ
    private String memberEncPassword;       // ��ȣȭ�� ȸ�� ��й�ȣ
    private String memberPhone;             // ȸ�� ��ȭ��ȣ
    private String memberEmail;             // ȸ�� �̸���
    private Date memberJoinDate;            // ȸ�� ������
    private String joinDate;                // ������ ���ڿ� ����
    private String memberEnabled;           // ȸ�� Ȱ��ȭ ����
    private Role memberRole;                // ȸ�� ���� (����)

    // Member ��� ������ ����
    private int totalCount;                 // �� ������ ����
    private int startIdx;                   // �������� ���� �ε���
    private int endIdx;                     // �������� �� �ε���
    
    // Member �˻�
    private String searchTitle;             // �˻� ����
    private String searchValue;             // �˻� ��
}
