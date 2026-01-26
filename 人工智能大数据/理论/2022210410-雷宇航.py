# 创建诗歌类
class Poem:
    def __init__(self,file_path,choice):
        self.file_path=file_path        # 路径实例
        self.choice=choice              # 方式示例
        self.lines=[]                   # 创建实例空列表

    # 导入诗歌
    def LoadPoetry(self):
        print('请输入诗歌每一行用空格隔开')
        self.L = input().split()
        for i in range(len(self.L)):
            self.L[i] = self.L[i] + '\n'  # 加入换行符 便于写入文件有好观感

    # 写入诗歌
    def WritePoetry(self):
        try:
            with open(file_path, 'w') as file:
                file.writelines(self.L)  # 以writelines 方式写入
        except Exception as e:
            print(f"An Unexpected Error Occurred:{e}")

    # 读取方式 权限：私有
    # file.read() 读取
    def __ReadPoetry1(self):
        try:
            with open(self.file_path, 'r') as file:
                lines1 = file.read()  # 整体读出 lines1 是一个字符串
            self.lines = lines1.split('\n')  # 以换行符进行字符串切割
        except FileNotFoundError:
            print('Error: The File Does Not Exist!')
        except PermissionError:
            print('Error: You Do Not Have Permisiion To Read The File!')
        except Exception as e:
            print(f"An Unexpected Error Occurred:{e}")

    # file.readlines() 读取
    def __ReadPoetry2(self):
        try:
            with open(self.file_path, 'r') as file:
                self.lines = file.readlines()  # 整体读出 linse2 是一个列表 元素是字符串
        except FileNotFoundError:
            print('Error: The File Does Not Exist!')
        except PermissionError:
            print('Error: You Do Not Have Permisiion To Read The File!')
        except Exception as e:
            print(f"An Unexpected Error Occurred:{e}")

    # file.readline() 读取
    def __ReadPoetry3(self):
        try:
            with open(self.file_path, 'r') as file:
                line = file.readline()
                self.lines.append(line)  # 将读出的字符串添加到列表
                while line != '':
                    line = file.readline()
                    if line != '':  # 避免列表后面会添加空字符串
                        self.lines.append(line)
        except FileNotFoundError:
            print('Error: The File Does Not Exist!')
        except PermissionError:
            print('Error: You Do Not Have Permisiion To Read The File!')
        except Exception as e:
            print(f"An Unexpected Error Occurred:{e}")

    # for循环 读取
    def __ReadPoetry4(self):
        try:
            with open(self.file_path, 'r') as file:
                for line in file:
                    self.lines.append(line)
        except FileNotFoundError:
            print('Error: The File Does Not Exist!')
        except PermissionError:
            print('Error: You Do Not Have Permisiion To Read The File!')
        except Exception as e:
            print(f"An Unexpected Error Occurred:{e}")

    # 读取方式选择函数
    def Switch(self):
        if self.choice == 1:
            print('-----------read 读取-----------')
            self.__ReadPoetry1()
        elif self.choice == 2:
            print('-----------readlines 读取-----------')
            self.__ReadPoetry2()
        elif self.choice == 3:
            print('-----------readline 读取-----------')
            self.__ReadPoetry3()
        elif self.choice == 4:
            print('-----------for循环 读取-----------')
            self.__ReadPoetry4()
        else:
            print('ERROR')
    #诗歌输出
    def PrintPoetry(self):
        cnt = 0
        w = max(map(len, self.lines)) + 3  # 获取填充长度
        print('\n----诗歌朗诵----')
        for item in self.lines:
            if cnt <= 1:
                print(item.strip().center(w))
            else:
                print(item.strip())
            cnt += 1
        print('\n----首句朗诵----')
        print(self.lines[2].strip())

# 主函数
if __name__ == "__main__":
    # 文件拓展名输入
    print('请输入正确学号 姓名 题号')
    ID,Name,Num=(input().split())
    file_path=f"{ID}-{Name}-{Num}.txt"
    # 选择读取方式
    print('请选择读取诗歌方式：1~4')
    choice = int(input())
    while choice>=5 or choice<=0:
        print('读取方式选择有误，请重新选择1~4')
        choice=int(input())
    # 调用实例函数
    Poetry=Poem(file_path,choice)
    Poetry.LoadPoetry()
    Poetry.WritePoetry()
    Poetry.Switch()
    Poetry.PrintPoetry()
