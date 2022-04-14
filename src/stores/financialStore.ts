import { Assessment, PaymentDue, PaymentRecord } from "@myuic-api/types";
import { useQuery } from "vue-query";
import { client } from "../client";
import { useStudentStore } from "./studentStore";

export const useFinancialRecordQuery = () => {
  const studentStore = useStudentStore();
  return useQuery(
    'financial_records', 
    () => client.financialRecord(
      studentStore.currentSemesterId.toString()
    ), 
    {
      placeholderData: {
        assessments: {
          misc: Array(4).map<Assessment>(() => ({
            amount: 0,
            amount_paid: 0,
            balance: 0,
            description: '',
            priority: 1,
            type: 'misc'
          })),
          others: Array(3).map<Assessment>(() => ({
            amount: 0,
            amount_paid: 0,
            balance: 0,
            description: '',
            priority: 1,
            type: 'others'
          })),
          receivables: Array(8).map<Assessment>(() => ({
            amount: 0,
            amount_paid: 0,
            balance: 0,
            description: '',
            priority: 1,
            type: 'receivables'
          })),
          tuition: Array(8).map<Assessment>(() => ({
            amount: 0,
            amount_paid: 0,
            balance: 0,
            description: '',
            priority: 1,
            type: 'tuition'
          }))
        },
        monthlyDues: Array(5).map<PaymentDue>((_, i) => ({
          amount: 0,
          balance: 0,
          month: i,
          remarks: '',
          semesterId: 0,
          status: ''
        })),
        paymentHistory: Array(3).map<PaymentRecord>(() => ({
          amount: 0,
          cashier: '',
          orNo: '',
          orSig: '',
          paidAt: new Date()
        }))
      },
      enabled: studentStore.hasSemesterId
    }
  );
};

export function getBreakdownSubtotal(entries: Assessment[]) {
  return entries.reduce((p, v) => p + v.amount, 0);
};