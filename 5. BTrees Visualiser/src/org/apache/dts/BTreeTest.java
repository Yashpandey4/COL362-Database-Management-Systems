package org.apache.dts;

import java.util.Map;
import java.util.Random;
import java.util.TreeMap;


public class BTreeTest
{
    private final BTree<Integer, String> mBTree;
    private final Map<Integer, String> mMap;
    private BTTestIteratorImpl<Integer, String> mIter;


    public BTreeTest() {
        mBTree = new BTree<Integer, String>();
        mMap = new TreeMap<Integer, String>();
        mIter = new BTTestIteratorImpl<Integer, String>();
    }

    public BTree<Integer, String> getBTree() {
        return mBTree;
    }

    public BTNode<Integer, String> getRootNode() {
        return mBTree.getRootNode();
    }

    protected void add(Integer key, String value) {
        mMap.put(key, value);
        mBTree.insert(key, value);
    }

    protected void delete(Integer key) throws BTException {
        System.out.println("Delete key = " + key);
        String strVal1 = mMap.remove(key);
        String strVal2 = mBTree.delete(key);
        if (!isEqual(strVal1, strVal2)) {
            throw new BTException("Deleted key = " + key + " has different values: " + strVal1 + " | " + strVal2);
        }
    }

    private void clearData() {
        mBTree.clear();
        mMap.clear();
    }

    public void listItems(BTIteratorIF<Integer, String> iterImpl) {
        mBTree.list(iterImpl);
    }

    public void addManualKeys() {
        System.out.println("Adding manual keys to the tree ...");
        add(35, "hello");
        add(25, "world!");
        add(12, "hey");
        add(40, "dude");
        add(9, "extra9");
        add(4, "extra4");
        add(100, "extra100");
        add(45, "extra45");
        add(80, "hello80");
        add(81, "world!81");
        add(1, "hey1");
        add(402, "dude402");
        add(2, "extra2");
        add(36, "extra36");
        add(101, "extra101");
        add(43, "extra43");

        // Add more for testing
        add(75, "hello75");
        add(13, "world!13");
        add(27, "hey27");
        add(29, "dude29");
        add(309, "extra309");
        add(213, "extra213");
        add(103, "extra103");
        add(125, "extra125");

        // Add more for testing
        add(175, "hello175");
        add(53, "world!53");
        add(127, "hey127");
        add(49, "dude49");
        add(89, "extra89");
        add(17, "extra17");
        add(91, "extra91");
        add(99, "extra99");

        // Add more for testing
        add(65, "hello165");
        add(63, "world!63");
        add(10, "hey10");
        add(47, "dude47");
        add(69, "extra69");
        add(97, "extra97");
        add(95, "extra95");
        add(7, "extra7");

        // Add more for testing
        add(265, "hello1265");
        add(263, "world!263");
        add(110, "hey110");
        add(407, "dude407");
        add(169, "extra169");
        add(297, "extra297");
        add(295, "extra295");
        add(37, "extra37");

        // Add more for testing
        add(175, "hello175");
        add(53, "world!53");
        add(127, "hey127");
        add(239, "dude239");
        add(89, "extra89");
        add(17, "extra1717");
        add(91, "extra91");
        add(99, "extra99");

        // Add more for testing
        add(65, "hello65");
        add(63, "world!63");
        add(59, "hey59");
        add(149, "dude149");
        add(8, "extra8");
        add(117, "extra117");
        add(291, "extra291");
        add(249, "extra249");

        add(388, "extra388");
        add(317, "extra317");
        add(391, "extra391");
        add(349, "extra349");
    }


    public void addRandomKeys() {
        int minNum = 10;
        int maxNum = 3000;
        int itemNum = 3000;
        int nVal;
        System.out.println("Adding random key between " + minNum + " and " + maxNum);
        for (int i = 0; i < itemNum; ++i) {
            nVal = randInt(minNum, maxNum);
            add(nVal, "random-" + nVal);
        }
    }


    private boolean isEqual(String strVal1, String strVal2) {
        if ((strVal1 == null) && (strVal2 == null)) {
            return true;
        }

        if ((strVal1 == null) && (strVal2 != null)) {
            return false;
        }

        if ((strVal1 != null) && (strVal2 == null)) {
            return false;
        }

        if (!strVal1.equals(strVal2)) {
            return false;
        }

        return true;
    }


    public void validateSize() throws BTException {
        System.out.println("Validate size ...");
        if (mMap.size() != mBTree.size()) {
            throw new BTException("Error in validateSize(): Failed to compare the size:  " + mMap.size() + " <> " + mBTree.size());
        }
    }


    public void validateSearch(Integer key) throws BTException {
        System.out.println("Validate search for key = " + key + " ...");
        String strVal1 = mMap.get(key);
        String strVal2 = mBTree.search(key);

        if (!isEqual(strVal1, strVal2)) {
            throw new BTException("Error in validateSearch(): Failed to compare value for key = " + key);
        }
    }


    public void validateData() throws BTException {
        System.out.println("Validate data ...");

        for (Map.Entry<Integer, String> entry : mMap.entrySet()) {
            try {
                // System.out.println("Search key = " + entry.getKey());
                String strVal = mBTree.search(entry.getKey());
                if (!isEqual(entry.getValue(), strVal)) {
                    throw new BTException("Error in validateData(): Failed to compare value for key = " + entry.getKey());
                }
            }
            catch (Exception ex) {
                ex.printStackTrace();
                throw new BTException("Runtime Error in validateData(): Failed to compare value for key = " + entry.getKey() + " msg = " + ex.getMessage());
            }
        }
    }


    public void validateOrder() throws BTException {
        System.out.println("Validate the order of the keys ...");
        mIter.reset();
        mBTree.list(mIter);
        if (!mIter.getStatus()) {
            throw new BTException("Error in validateData(): Failed to compare value for key = " + mIter.getCurrentKey());
        }
    }


    public void validateAll() throws BTException {
        validateData();
        validateSize();
        validateOrder();
    }


    public void addKey(int i) {
        add(i, "value-" + i);
    }


    public void validateTestCase0() throws BTException {
        System.out.println();
        System.out.println("+ Running TestCase0 validation");

        addManualKeys();
        validateAll();
        validateSearch(40);
        validateSearch(9);
        validateSearch(25);
        validateSearch(100);
        validateSearch(91);
        validateSearch(17);

        delete(91);
        validateAll();

        delete(25);
        validateAll();

        addRandomKeys();
        validateAll();

        delete(91);
        delete(13);
        validateSearch(17);
        validateSearch(29);
        validateSearch(75);
        delete(175);
        delete(80);

        validateSearch(25);
        validateSearch(13);
        validateSearch(99);
        validateSearch(91);

        delete(17);
        validateSearch(17);
        delete(75);
        validateSearch(29);
        validateSearch(75);

        delete(35);
        delete(25);
        delete(12);
        delete(40);
        delete(9);
        delete(4);

        delete(100);

        delete(45);

        validateSearch(40);
        validateSearch(12);
        validateSearch(100);
    }


    public void validateTestCase1() throws BTException {
        System.out.println();
        System.out.println("+ Running TestCase1 validation");
        clearData();
        for (int i = 1; i != 19; ++i) {
            addKey(i);
        }
        delete(12);
        delete(15);
        delete(19);
        delete(2);
        validateAll();
    }


    public void validateTestCase2() throws BTException {
        System.out.println();
        System.out.println("+ Running TestCase2 validation");
        clearData();
        for (int i = 1; i != 32; ++i) {
            addKey(i);
        }

        delete(3);
        delete(7);
        delete(8);
        delete(6);
        validateAll();
    }


    public void validateTestCase3() throws BTException {
        System.out.println();
        System.out.println("+ Running TestCase3 validation");
        clearData();
        for (int i = 1; i != 50; ++i) {
            addKey(i);
        }

        delete(24);
        delete(23);
        delete(27);
        delete(26);
        delete(25);
        delete(9);
        delete(8);
        delete(7);
        delete(6);
        delete(5);
        delete(4);
        delete(3);
        validateAll();
    }


    public void validateTestCase4() throws BTException {
        System.out.println();
        System.out.println("+ Running TestCase4 validation");
        clearData();
        for (int i = 1; i != 80; ++i) {
            addKey(i);
        }

        delete(24);
        delete(23);
        delete(27);
        delete(26);
        delete(25);
        delete(9);
        delete(8);
        delete(7);
        delete(6);
        delete(5);
        delete(4);
        delete(3);

        delete(2);
        delete(1);
        for (int i = 30; i != 10; --i) {
            delete(i);
        }
        delete(36);
        validateAll();
    }


    public void validateTestCase5() throws BTException {
        System.out.println();
        System.out.println("+ Running TestCase5 validation");
        clearData();
        int itemNum = 40000;
        for (int i = 0; i != itemNum; ++i) {
            addKey(i);
        }

        for (int i = -10; i < 100; ++i) {
            validateSearch(i);
        }
        validateAll();

        for (int i = itemNum; i != 0; --i) {
            delete(i);
            validateAll();
        }
        validateAll();
    }


    public void validateTestCase6() throws BTException {
        System.out.println();
        System.out.println("+ Running TestCase6 validation");
        clearData();
        int itemNum = 40000;
        for (int i = itemNum; i > 0; --i) {
            addKey(i);
        }

        for (int i = -10; i < 200; ++i) {
            validateSearch(i);
        }
        validateAll();


        for (int i = 1; i != itemNum; ++i) {
            delete(i);
            validateAll();
        }
    }


    /**
     * Main Entry for the test
     * @param args 
     */
    public static void main(String []args) {
        BTreeTest test = new BTreeTest();

        try {
            test.validateTestCase0();
            test.validateTestCase1();
            test.validateTestCase2();
            test.validateTestCase3();
            test.validateTestCase4();
            test.validateTestCase5();
            test.validateTestCase6();
            System.out.println("BTree validation is successfully complete.");
        }
        catch (BTException btex) {
            System.out.println("BTException msg = " + btex.getMessage());
            btex.printStackTrace();
        }
        catch (Exception ex) {
            System.out.println("BTException msg = " + ex.getMessage());
            ex.printStackTrace();
        }
    }


    //
    // Randomly generate integer within the specified range
    //
    public static int randInt(int min, int max) {
        Random rand = new Random();

        // nextInt is normally exclusive of the top value,
        // so add 1 to make it inclusive
        int randomNum = rand.nextInt((max - min) + 1) + min;

        return randomNum;
    }


    /**
     * Inner class to implement BTree iterator
     */
    class BTTestIteratorImpl<K extends Comparable, V> implements BTIteratorIF<K, V> {
        private K mCurrentKey;
        private K mPreviousKey;
        private boolean mStatus;


        public BTTestIteratorImpl() {
            reset();
        }

        @Override
        public boolean item(K key, V value) {
            mCurrentKey = key;
            if ((mPreviousKey != null) && (mPreviousKey.compareTo(key) > 0)) {
                mStatus = false;
                return false;
            }
            mPreviousKey = key;
            return true;
        }

        public boolean getStatus() {
            return mStatus;
        }

        public K getCurrentKey() {
            return mCurrentKey;
        }

        public final void reset() {
            mPreviousKey = null;
            mStatus = true;
        }
    }
}
