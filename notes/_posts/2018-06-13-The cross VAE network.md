---
layout: post
category: notes
title: The cross VAE network
---
## Discussion With Professor
Yesterday I showed my thoughts to professor and she gave me some valuable suggestions. Here is the memo or reminder.

1. The Estimator which can get one possible solution is hard. Now many people just research on it.
2. It may be unnecessary to get the position of one occluded joint.
3. The diversity or some transfer between the solution space. Some **important references** related to body pose estiamtion should be noted.
4. We talk about the paper <sup>1</sup>. 
    * This idea is novelty.
    * There is no way to measure its performance.
    * Not consider the hand model constraints.
    * Of course, **application** is also an important issue.

## Daily Code Study
1. Python面向对象编程中，类中定义的方法有
    * @classmethod 装饰的类方法 - 类方法，不管是 实例 还是 类，都是已经自动绑定了类对象的方法 - 第一个参数为cls代表类
    * @staticmethod 装饰的静态方法 - 静态方法，跟普通函数没什么区别，与类和实例都没有所谓的绑定关系，不论是通过类还是实例都可以引用该方法
    * 不带装饰器的实例方法 - 必须显式地传入一个实例对象进去 - 第一个参数是self，代表类的实例而非类
2. python类函数的命名
    * _x: 单前置下划线,私有化属性或方法，from somemodule import *禁止导入,但是使用import module可以获取。**类对象和子类可以访问**。表示这是一个保护成员，只有 *类对象和子类对象自己能访问* 到这些变量。以单下划线开头的变量和函数被默认当作是内部函数。
    * __xx：双下划线开头的命名形式在类成员中使用表示名字改编。双前置下划线,避免与子类中的属性命名冲突。*只允许类本身访问*，子类也不行。在文本上被替换为_class__method。**无法在外部直接访问,使用 _Class__object可以访问**。因为使用了class信息，可以防止与子类中的命名冲突
    * \_\_xx\_\_:双前后下划线,用户名字空间的魔法对象或属性，表示是*特殊成员*。例如:\_\_init\_\_() \_\_del\_\_() \_\_call\_\_()
    * xx_:单后置下划线,用于避免与Python关键词的冲突，仅仅是为了区别该名称与关键词






## Reference
[1] Occlusion-aware Hand Pose Estimation Using Hierarchical Mixture Density Network  